// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/crypto.dart';
import 'dart:convert';
import 'dart:async';

import 'package:web3dart/web3dart.dart';

// ERC20 ABI
const erc20Abi = [
  {
    "constant": true,
    "inputs": [
      {
        "name": "_owner",
        "type": "address"
      },
      {
        "name": "_spender",
        "type": "address"
      }
    ],
    "name": "allowance",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_spender",
        "type": "address"
      },
      {
        "name": "_value",
        "type": "uint256"
      }
    ],
    "name": "approve",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  }
];

class SwapController extends GetxController {
  final walletCreatingCotroller = Get.find<WalletCreatingController>();
  var balanceController = TextEditingController();

  // 1inch API configuration
  static const String chainId = '1'; // Ethereum mainnet
  static const String oneInchUrl = 'https://api.1inch.io/v5.0';
  // Get API key from env
  String get oneInchApiKey => dotenv.get('ONE_INCH_API_KEY', fallback: '');

  // 0x API configuration
  static const String zeroXUrl = 'https://api.0x.org/swap/permit2';
  // Get API key from env
  String get zeroXApiKey => dotenv.get('ZEROX_API_KEY', fallback: '');

  // Permit2 contract address
  static const String permit2Address = '0x000000000022D473030F116dDEE9F6B43aC78BA3';

  // Existing variables
  RxDouble usdAmount = 0.0.obs;
  RxDouble cryptoAmount = 0.0.obs;
  RxDouble usdAmount2nd = 0.0.obs;
  RxDouble cryptoAmount2nd = 0.0.obs;

  // New variables for 1inch
  var isLoading = false.obs;
  final currentQuote = RxMap<String, dynamic>({});
  Timer? quoteTimer;
  var swapRate = 0.0.obs;
  var networkFee = 0.0.obs;

  // Add a computed property to check if swap is possible
  bool get canSwap => 
    !isLoading.value && 
    currentQuote.isNotEmpty && 
    cryptoAmount.value > 0;

  // Add these new observable variables at the top of your controller
  RxString provider = "0x Protocol".obs;
  RxDouble maxSlippage = 0.0.obs;
  RxString networkFeeInEth = "0.000".obs;

  // Add getters for formatted display
  String get formattedProvider => provider.value;
  
  String get formattedSlippage {
    if (currentQuote.isEmpty) return "0.00%";
    try {
      double slippage = double.parse(currentQuote['slippagePercentage'] ?? '0.01') * 100;
      return "${slippage.toStringAsFixed(2)}%";
    } catch (e) {
      return "1.00%"; // Default fallback
    }
  }
     final swapFormKey = GlobalKey<FormState>();
   String? validateBLance(String? value) {
      if (value == null || value.isEmpty) {
        return 'Balance is required';
      }
  else if (value == "0") {
        return "Balance cannot be zero";
        }
      // Add additional address validation if needed
      return null;
    }
    bool validateForm() {
      return swapFormKey.currentState?.validate() ?? false;
    }
    // Execute swap
  
  String get formattedNetworkFee {
    if (currentQuote.isEmpty) return "0.000 ETH";
    try {
      double estimatedGas = double.parse(currentQuote['estimatedGas']);
      double gasPrice = double.parse(currentQuote['gasPrice']);
      double fee = (estimatedGas * gasPrice) / 1e18;
      return "${fee.toStringAsFixed(5)} ETH";
    } catch (e) {
      return "0.000 ETH";
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (walletCreatingCotroller.tokenData.isNotEmpty) {
      firstToken.value = walletCreatingCotroller.tokenData[0];
      secondToken.value = walletCreatingCotroller.tokenData[1];
    }
  }

  // Update amount with 1inch quote
  void updateAmount(String value, double coinPrice) {
    if (value.isEmpty) {
      usdAmount.value = 0.0;
      cryptoAmount.value = 0.0;
      usdAmount2nd.value = 0.0;
      cryptoAmount2nd.value = 0.0;
      return;
    }

    try {
      // Remove $ sign and parse the value
      String cleanValue = value.replaceAll('\$', '');
      usdAmount.value = double.tryParse(cleanValue) ?? 0.0;
      
      // Convert USD to crypto amount
      cryptoAmount.value = usdAmount.value / coinPrice;
      
      if (cryptoAmount.value > 0) {
        getSwapQuote();
      }
    } catch (e) {
      print('Error in updateAmount: $e');
    }
  }

  // Get real-time quote from 1inch
  Future<void> getSwapQuote() async {
    if (cryptoAmount.value <= 0) return;

    try {
      isLoading(true);

      // Convert amount to wei (18 decimals)
      String amount = (cryptoAmount.value * 1e18).toStringAsFixed(0);
      
      // Get token addresses
      String sellTokenAddress = firstToken.value.contractAddress;
      String buyTokenAddress = secondToken.value.contractAddress;

      // Handle ETH addresses correctly
      if (firstToken.value.symbol == "ETH") {
        sellTokenAddress = "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE";
      }
      if (secondToken.value.symbol == "ETH") {
        buyTokenAddress = "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE";
      }

      // Ensure addresses are in checksum format
      sellTokenAddress = sellTokenAddress.toLowerCase();
      buyTokenAddress = buyTokenAddress.toLowerCase();

      // Ensure minimum slippage of 0.1%
      double slippage = maxSlippage.value < 0.1 ? 0.1 : maxSlippage.value;

      final url = Uri.parse(
        '$zeroXUrl/price'
        '?sellToken=$sellTokenAddress'
        '&buyToken=$buyTokenAddress'
        '&sellAmount=$amount'
        '&slippagePercentage=${slippage / 100}'
        '&taker=${walletCreatingCotroller.wallwtAddress.value.toLowerCase()}'
        '&chainId=1'
      );

      print('Request URL: $url');
      print('Sell Token: $sellTokenAddress');
      print('Buy Token: $buyTokenAddress');
      print('Amount: $amount');
      print('Slippage: ${slippage / 100}');

      if (zeroXApiKey.isEmpty) {
        throw Exception('0x API key is missing. Please add it to your .env file');
      }

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          '0x-api-key': zeroXApiKey,
          '0x-version': 'v2',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final quote = json.decode(response.body);
        currentQuote.value = quote;

        // Update slippage from quote with null check
        maxSlippage.value = double.tryParse(quote['slippagePercentage']?.toString() ?? '0.01') ?? 0.01 * 100;

        // Calculate network fee with null checks
        final estimatedGas = double.tryParse(quote['gas']?.toString() ?? '0') ?? 0;
        final gasPrice = double.tryParse(quote['gasPrice']?.toString() ?? '0') ?? 0;
        networkFee.value = estimatedGas * gasPrice / 1e18;

        // Calculate the exchange rate with null checks
        double fromAmount = double.tryParse(quote['sellAmount']?.toString() ?? '0') ?? 0;
        double toAmount = double.tryParse(quote['buyAmount']?.toString() ?? '0') ?? 0;
        
        // Convert from wei to token units
        fromAmount = fromAmount / 1e18;
        toAmount = toAmount / 1e6; // USDT has 6 decimals
        
        if (fromAmount > 0) {
          swapRate.value = toAmount / fromAmount;
        } else {
          swapRate.value = 0;
        }
        
        // Update second token amounts with null checks
        cryptoAmount2nd.value = toAmount;
        usdAmount2nd.value = toAmount * secondToken.value.priceInUsd;

        updateAmount2nd();
      } else if (response.statusCode == 403) {
        throw Exception('Invalid or expired 0x API key. Please update your .env file with a valid key');
      } else {
        print('API Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to get quote: ${response.body}');
      }
    } catch (e) {
      print('Error in getSwapQuote: $e');
      Get.snackbar(
        'Error',
        e.toString(),
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // Start real-time quote updates
  void startQuoteUpdates() {
    quoteTimer?.cancel();
    quoteTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (cryptoAmount.value > 0) {
        getSwapQuote();
      }
    });
  }

  // Execute swap
  Future<void> executeSwap() async {
    debugPrintSwapDetails();
    try {
      isLoading(true);
      
      if (currentQuote.isEmpty) {
        throw Exception('No valid quote found');
      }

      // Convert amount to wei (18 decimals)
      String amount = (cryptoAmount.value * 1e18).toStringAsFixed(0);
      
      // Get token addresses
      String sellTokenAddress = firstToken.value.contractAddress;
      String buyTokenAddress = secondToken.value.contractAddress;

      // Handle ETH addresses correctly
      if (firstToken.value.symbol == "ETH") {
        sellTokenAddress = "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE";
      }
      if (secondToken.value.symbol == "ETH") {
        buyTokenAddress = "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE";
      }

      // Ensure addresses are in checksum format
      sellTokenAddress = sellTokenAddress.toLowerCase();
      buyTokenAddress = buyTokenAddress.toLowerCase();

      // Ensure minimum slippage of 0.1%
      double slippage = maxSlippage.value < 0.1 ? 0.1 : maxSlippage.value;

      final url = Uri.parse(
        '$zeroXUrl/quote'
        '?sellToken=$sellTokenAddress'
        '&buyToken=$buyTokenAddress'
        '&sellAmount=$amount'
        '&slippagePercentage=${slippage / 100}'
        '&taker=${walletCreatingCotroller.wallwtAddress.value.toLowerCase()}'
        '&chainId=1'
      );

      print('Executing swap with URL: $url');
      print('Sell Token: $sellTokenAddress');
      print('Buy Token: $buyTokenAddress');
      print('Amount: $amount');
      print('Slippage: ${slippage / 100}');

      if (zeroXApiKey.isEmpty) {
        throw Exception('0x API key is missing. Please add it to your .env file');
      }

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          '0x-api-key': zeroXApiKey,
          '0x-version': 'v2',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final swapQuote = json.decode(response.body);
        
        // Check if we have the required fields for transaction
        if (!swapQuote.containsKey('transaction') || 
            !swapQuote['transaction'].containsKey('to') || 
            !swapQuote['transaction'].containsKey('data')) {
          print('Invalid quote format: $swapQuote');
          throw Exception('Invalid quote format received');
        }

        // Check if we need to approve Permit2
        if (swapQuote.containsKey('permit2') && swapQuote['permit2'] != null) {
          await approvePermit2(sellTokenAddress, amount);
        }

        await submitTransaction(swapQuote['transaction']);
        
        resetSwap();
        balanceController.clear();
        
        Get.snackbar(
          'Success',
          'Swap order created successfully',
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode == 403) {
        throw Exception('Invalid or expired 0x API key. Please update your .env file with a valid key');
      } else {
        throw Exception('Failed to get swap quote: ${response.body}');
      }
    } catch (e) {
      print('Full error details in executeSwap: $e');
      Get.snackbar(
        'Error',
        e.toString(),
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // Reset swap state
  void resetSwap() {
    usdAmount.value = 0.0;
    cryptoAmount.value = 0.0;
    usdAmount2nd.value = 0.0;
    cryptoAmount2nd.value = 0.0;
    currentQuote.clear();
    quoteTimer?.cancel();
  }

  @override
  void onClose() {
    quoteTimer?.cancel();
    balanceController.dispose();
    super.onClose();
  }

  // Two observable TokenData variables
  var firstToken = TokenData(
    symbol: "",
    logoUrl: "",
    contractAddress: "",
    name: "",
    balance: 0.0,
    balanceInUsd: 0.0,
    priceInUsd: 0.0,
    trend: "",
    trendPercentage: 0.0,
  ).obs;

  var secondToken = TokenData(
    symbol: "",
    logoUrl: "",
    contractAddress: "",
    name: "",
    balance: 0.0,
    balanceInUsd: 0.0,
    priceInUsd: 0.0,
    trend: "",
    trendPercentage: 0.0,
  ).obs;

  // Function to update tokens
  void updateFirstToken(TokenData token) {
    firstToken.value = token;
    if (usdAmount.value > 0) {
      getSwapQuote();
    }
    Get.back();
  }

  void updateSecondToken(TokenData token) {
    secondToken.value = token;
    if (usdAmount.value > 0) {
      getSwapQuote();
    }
    Get.back();
  }
var oneFirstCoinEquelsSecondCoins=0.0.obs;
  void updateAmount2nd() {
    cryptoAmount2nd.value = usdAmount2nd.value / secondToken.value.priceInUsd;
oneFirstCoinEquelsSecondCoins.value=  firstToken.value.priceInUsd/secondToken.value.priceInUsd;
  }

  // Calculate percentage of balance
  void calculatePercentage(double percentage) {
    // Calculate USD amount based on percentage of first token's balance in USD
    double maxUsdAmount = firstToken.value.balanceInUsd;
    double calculatedUsdAmount = (maxUsdAmount * percentage) / 100;
    
    // Update the balance controller with the calculated amount
    balanceController.text = calculatedUsdAmount.toStringAsFixed(2);
    
    // Update amounts using existing method
    updateAmount(calculatedUsdAmount.toString(), firstToken.value.priceInUsd);
  }
  Future<void> submitTransaction(Map<String, dynamic> swapQuote) async {
    try {
      // Create a new client for each transaction
      final client = Web3Client(
        "https://mainnet.infura.io/v3/${dotenv.get('INFURA_API_KEY')}",
        http.Client(),
      );

      try {
        final credentials = EthPrivateKey.fromHex(walletCreatingCotroller.privateKey!);
        
        // Get the current nonce
        final nonce = await client.getTransactionCount(credentials.address);
        
        // Get current gas price
        final gasPrice = await client.getGasPrice();
        
        // Convert hex data to bytes
        final data = hexToBytes(swapQuote['data']);
        
        // Prepare transaction parameters
        final transaction = Transaction(
          to: EthereumAddress.fromHex(swapQuote['to']),
          value: EtherAmount.inWei(BigInt.parse(swapQuote['value'] ?? '0')),
          data: data,
          maxGas: int.parse(swapQuote['gas'] ?? '150000'), // Default gas limit if not provided
          gasPrice: gasPrice, // Use current network gas price
          nonce: nonce,
        );

        // Print debug information
        print('Submitting transaction with parameters:');
        print('From: ${credentials.address}');
        print('To: ${transaction.to}');
        print('Value: ${transaction.value?.getInWei}');
        print('Nonce: ${transaction.nonce}');
        print('Gas Price: ${transaction.gasPrice?.getInWei}');
        print('Max Gas: ${transaction.maxGas}');
        print('Data: ${bytesToHex(data)}');

        // Estimate gas before sending (optional but recommended)
        final estimatedGas = await client.estimateGas(
          sender: credentials.address,
          to: transaction.to,
          value: transaction.value,
          data: data,
        );

        print('Estimated Gas: $estimatedGas');

        // Send the transaction
        final txHash = await client.sendTransaction(
          credentials,
          transaction,
          chainId: 1, // Mainnet
        );

        print('Transaction submitted successfully!');
        print('Transaction hash: $txHash');

        // Monitor transaction status
        bool confirmed = false;
        int attempts = 0;
        
        while (!confirmed && attempts < 30) {
          try {
            final receipt = await client.getTransactionReceipt(txHash);
            if (receipt != null) {
              confirmed = true;
              print('Transaction confirmed! Receipt: $receipt');
              
              // Check if transaction was successful
              if (receipt.status == true) {
                Get.snackbar(
                  'Success',
                  'Transaction confirmed! Hash: ${txHash.substring(0, 10)}...',
                  duration: const Duration(seconds: 3),
                  snackPosition: SnackPosition.BOTTOM,
                );
              } else {
                throw Exception('Transaction failed');
              }
              break;
            }
          } catch (e) {
            print('Waiting for confirmation... Attempt ${attempts + 1}');
          }
          
          await Future.delayed(const Duration(seconds: 2));
          attempts++;
        }

        if (!confirmed) {
          throw Exception('Transaction confirmation timeout');
        }

      } catch (e) {
        print('Transaction error: $e');
        throw Exception('Transaction failed: $e');
      } finally {
        // Clean up the client
        client.dispose();
      }
    } catch (e) {
      print('Error in submitTransaction: $e');
      throw Exception('Transaction submission failed: $e');
    }
  }

  // Add method to update slippage
  void updateSlippage(double newSlippage) {
    maxSlippage.value = newSlippage;
    // Refresh quote with new slippage
    if (cryptoAmount.value > 0) {
      getSwapQuote();
    }
  }

  // Add this method to help debug
  void debugPrintSwapDetails() {
    print('Debug Swap Details:');
    print('Crypto Amount: ${cryptoAmount.value}');
    print('USD Amount: ${usdAmount.value}');
    print('First Token: ${firstToken.value.symbol}');
    print('Second Token: ${secondToken.value.symbol}');
    print('Current Quote: ${currentQuote}');
  }

  Future<void> approvePermit2(String tokenAddress, String amount) async {
    try {
      final client = Web3Client(
        "https://mainnet.infura.io/v3/${dotenv.get('INFURA_API_KEY')}",
        http.Client(),
      );

      final credentials = EthPrivateKey.fromHex(walletCreatingCotroller.privateKey!);
      
      // Create ERC20 contract instance
      final contract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(erc20Abi), 'ERC20'),
        EthereumAddress.fromHex(tokenAddress),
      );

      // Get current allowance
      final allowanceFunction = contract.function('allowance');
      final currentAllowance = await client.call(
        contract: contract,
        function: allowanceFunction,
        params: [
          credentials.address,
          EthereumAddress.fromHex(permit2Address),
        ],
      );

      // If allowance is less than amount, approve
      if (BigInt.parse(currentAllowance[0].toString()) < BigInt.parse(amount)) {
        final approveFunction = contract.function('approve');
        final approveTx = Transaction.callContract(
          contract: contract,
          function: approveFunction,
          parameters: [
            EthereumAddress.fromHex(permit2Address),
            BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007913129639935'), // max uint256
          ],
        );

        final txHash = await client.sendTransaction(
          credentials,
          approveTx,
          chainId: 1,
        );

        print('Approval transaction hash: $txHash');
        
        // Wait for transaction to be mined
        bool confirmed = false;
        int attempts = 0;
        while (!confirmed && attempts < 30) {
          try {
            final receipt = await client.getTransactionReceipt(txHash);
            if (receipt != null) {
              confirmed = true;
              print('Approval transaction confirmed!');
              break;
            }
          } catch (e) {
            print('Waiting for confirmation... Attempt ${attempts + 1}');
          }
          await Future.delayed(const Duration(seconds: 2));
          attempts++;
        }
      }
    } catch (e) {
      print('Error in approvePermit2: $e');
      throw Exception('Failed to approve Permit2: $e');
    }
  }
}








