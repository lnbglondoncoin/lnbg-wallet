// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Views/Transections/controller/transection_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/BottomNavigationBar/view/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:web3dart/crypto.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

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
  final transactionController = Get.put(TransactionController());
  // 1inch API configuration
  // static const String chainId = '1'; // Ethereum mainnet
  // static const String oneInchUrl = 'https://api.1inch.io/v5.0';
  // Get API key from env
  // String get oneInchApiKey => dotenv.get('ONE_INCH_API_KEY', fallback: '');

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
      double slippage =
          double.parse(currentQuote['slippagePercentage'] ?? '0.01') * 100;
      return "${slippage.toStringAsFixed(2)}%";
    } catch (e) {
      return "1.00%"; // Default fallback
    }
  }

  final swapFormKey = GlobalKey<FormState>();
  String? validateBLance(String? value) {
    if (value == null || value.isEmpty) {
      return 'Balance is required';
    } else if (value == "0") {
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
    return "${networkFeeInEth.value} ETH";
  }

  @override
  void onInit() {
    super.onInit();
    if (walletCreatingCotroller.tokenData.isNotEmpty) {
      firstToken.value = walletCreatingCotroller.tokenData[1];
      secondToken.value = walletCreatingCotroller.tokenData[2];
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

      // Get decimal places for both tokens
      int sellTokenDecimals =
          firstToken.value.symbol.toUpperCase() == "USDT" ||
                  firstToken.value.symbol.toUpperCase() == "USDC"
              ? 6
              : 18; // Default to 18 for most tokens
      int buyTokenDecimals =
          secondToken.value.symbol.toUpperCase() == "USDT" ||
                  secondToken.value.symbol.toUpperCase() == "USDC"
              ? 6
              : 18; // USDT has 6 decimals, others 18

      // Convert amount to wei based on sell token decimals
      String amount =
          (cryptoAmount.value * pow(10, sellTokenDecimals)).toStringAsFixed(0);

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
        '&chainId=1',
      );

      print('Request URL: $url');
      print('Sell Token: $sellTokenAddress');
      print('Buy Token: $buyTokenAddress');
      print('Amount: $amount');
      print('Slippage: ${slippage / 100}');

      if (zeroXApiKey.isEmpty) {
        throw Exception('0x API key is missing. Please add it to your .env file');
      }

      await retryRequest(() async {
        final response = await http.get(
          url,
          headers: {
            'Accept': 'application/json',
            '0x-api-key': zeroXApiKey,
            '0x-version': 'v2',
          },
        );

        if (response.statusCode == 200) {
          final quote = json.decode(response.body);
          currentQuote.value = quote;

          // Update slippage from quote with null check
          maxSlippage.value = double.tryParse(
                  quote['slippagePercentage']?.toString() ?? '0.01') ??
              0.01 * 100;

          // Calculate network fee with null checks
          final estimatedGas =
              double.tryParse(quote['gas']?.toString() ?? '0') ?? 0;
          final gasPrice =
              double.tryParse(quote['gasPrice']?.toString() ?? '0') ?? 0;
          networkFee.value = (estimatedGas * gasPrice) / 1e18; // Convert from wei to ETH

          // Update network fee display
          networkFeeInEth.value = networkFee.value.toStringAsFixed(6);

          // Calculate the exchange rate with null checks
          double fromAmount =
              double.tryParse(quote['sellAmount']?.toString() ?? '0') ?? 0;
          double toAmount =
              double.tryParse(quote['buyAmount']?.toString() ?? '0') ?? 0;

          // Convert from wei to token units based on token decimals
          fromAmount = fromAmount / pow(10, sellTokenDecimals);
          toAmount = toAmount / pow(10, buyTokenDecimals);

          if (fromAmount > 0) {
            swapRate.value = toAmount / fromAmount;
          } else {
            swapRate.value = 0;
          }

          // Update second token amounts with null checks
          cryptoAmount2nd.value = toAmount;
          usdAmount2nd.value = toAmount * secondToken.value.priceInUsd;

          updateAmount2nd();
        } else {
          throw Exception('Failed to get quote: ${response.body}');
        }
      });
    } catch (e) {
      isLoading(false);
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

  // Updated executeSwap method to handle XT API for specific token addresses
  Future<void> executeSwap() async {
    debugPrintSwapDetails();
    try {
      isLoading(true);

      if (currentQuote.isEmpty) {
        throw Exception('No valid quote found');
      }

      // Check user balance
      if (firstToken.value.balance < cryptoAmount.value) {
        Get.snackbar(
          'Error',
          'Insufficient balance to perform the swap.',
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
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

      // Check if XT API should be used
      const xtTokenAddress = "0xdb6675d9740f6401dcd0bb3092fa4dc88c2a0f66";
      if (sellTokenAddress == xtTokenAddress || buyTokenAddress == xtTokenAddress) {
        await executeSwapWithXTAPI(sellTokenAddress, buyTokenAddress, amount);
        return;
      }

      // Ensure minimum slippage of 0.1%
      double slippage = maxSlippage.value < 0.1 ? 0.1 : maxSlippage.value;

      final url = Uri.parse(
        '$zeroXUrl/quote'
        '?sellToken=$sellTokenAddress'
        '&buyToken=$buyTokenAddress'
        '&sellAmount=$amount'
        '&slippagePercentage=${slippage / 100}'
        '&taker=${walletCreatingCotroller.wallwtAddress.value.toLowerCase()}'
        '&chainId=1',
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
Get.log("Swapqoute=$swapQuote");
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

        final txHash = await submitTransaction(swapQuote['transaction']);

        // Post the transaction to our backend
        await transactionController.postTransaction(
          walletAddress: walletCreatingCotroller.wallwtAddress.value,
          hash: txHash,
          method: "swap",
          time: DateTime.now().toIso8601String(),
          from: walletCreatingCotroller.wallwtAddress.value,
          to: swapQuote['transaction']['to'],
          amount: cryptoAmount.value,
          fee: networkFee.value,
          token: firstToken.value.symbol.toUpperCase(),
          fromToken: firstToken.value.symbol.toUpperCase(),
          toToken: secondToken.value.symbol.toUpperCase(),
        );
        print("To is ${swapQuote['transaction']['to']}");

        // Clear the form and reset state before navigation
        resetSwap();
        balanceController.clear();

        // Fetch updated wallet data and transactions
        await walletCreatingCotroller.fetchWalletData(
          walletCreatingCotroller.wallwtAddress.value,
          false,
          false,
        );
        await transactionController.fetchTransactions(
          walletCreatingCotroller.wallwtAddress.value,
        );

        // Show success popup
        _showSuccesPopup(Get.context!);
      } else if (response.statusCode == 403) {
        throw Exception(
            'Invalid or expired 0x API key. Please update your .env file with a valid key');
      } else {
        throw Exception('Failed to get swap quote: ${response.body}');
      }
    } catch (e) {
      print('Full error details in executeSwap: $e');
      // Show failure popup with retry function
      _showFailPopup(Get.context!, e.toString(), executeSwap);
    } finally {
      isLoading(false);
    }
  }

  // New method to handle XT API swap
  Future<void> executeSwapWithXTAPI(String sellTokenAddress, String buyTokenAddress, String amount) async {
    try {
      final xtApiUrl = 'https://api.xt.com/swap'; // Replace with actual XT API URL

      final response = await http.post(
        Uri.parse(xtApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ' 27930a2d457d583c0cff956bd4a5f741f02546f8', // Replace with actual XT API key
        },
        body: json.encode({
          'sellToken': sellTokenAddress,
          'buyToken': buyTokenAddress,
          'amount': amount,
        }),
      );

      print('XT API Response status: ${response.statusCode}');
      print('XT API Response body: ${response.body}');

      if (response.statusCode == 200) {
        final xtResponse = json.decode(response.body);
        print('XT API Swap Successful: $xtResponse');

        // Handle XT API response and update UI or backend as needed
      } else {
        throw Exception('XT API Swap Failed: ${response.body}');
      }
    } catch (e) {
      print('Error in executeSwapWithXTAPI: $e');
      throw Exception('Failed to execute swap with XT API: $e');
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

  var oneFirstCoinEquelsSecondCoins = 0.0.obs;
  void updateAmount2nd() {
    cryptoAmount2nd.value = usdAmount.value / secondToken.value.priceInUsd;
    Get.log("cryptoAmount2nd ammount is ${cryptoAmount2nd.value.toString()}");
    Get.log("usd ammount is ${usdAmount.value.toString()}");
    Get.log("secondToken ammount is ${secondToken.value.priceInUsd.toString()}");
    oneFirstCoinEquelsSecondCoins.value =
        firstToken.value.priceInUsd / secondToken.value.priceInUsd;
  }

  // Add selected percentage state
  RxDouble selectedPercentage = 0.0.obs;

  // Update calculatePercentage method
  void calculatePercentage(double percentage) {
    // Update selected percentage
    selectedPercentage.value = percentage;

    // Calculate USD amount based on percentage of first token's balance in USD
    double maxUsdAmount = firstToken.value.balanceInUsd;
    double calculatedUsdAmount = (maxUsdAmount * percentage) / 100;

    // Update the balance controller with the calculated amount
    balanceController.text = calculatedUsdAmount.toStringAsFixed(2);

    // Update amounts using existing method
    updateAmount(calculatedUsdAmount.toString(), firstToken.value.priceInUsd);
  }

  Future<String> submitTransaction(Map<String, dynamic> swapQuote) async {
    try {
      try {
        final client = Web3Client(
          "https://mainnet.infura.io/v3/${dotenv.get('INFURA_API_KEY')}",
          http.Client(),
        );

        try {
          final credentials =
              EthPrivateKey.fromHex(walletCreatingCotroller.privateKey!);

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
          print('Value: ${EtherAmount.inWei(BigInt.parse(swapQuote['value'] ?? '0'))}');
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

          // Monitor transaction status with increased timeout
          await waitForTransactionConfirmation(txHash);

          return txHash;
        } catch (e) {
          print('Transaction error: $e');
          throw Exception('Transaction failed: $e');
        } finally {
          // Clean up the client
          client.dispose();
        }
      } catch (e) {
        print('Network error: $e');
        Get.snackbar(
          'Network Error',
          'Unable to connect to the blockchain. Please check your internet connection.',
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        );
        throw Exception('Transaction submission failed: $e');
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
            BigInt.parse(
                '115792089237316195423570985008687907853269984665640564039457584007913129639935'), // max uint256
          ],
        );

        final txHash = await client.sendTransaction(
          credentials,
          approveTx,
          chainId: 1,
        );

        print('Approval transaction hash: $txHash');

        // Wait for transaction confirmation
        await waitForTransactionConfirmation(txHash);

        // Retry allowance check
        final updatedAllowance = await getUpdatedAllowance(
          contract,
          permit2Address,
          credentials.address.hex,
        );

        if (updatedAllowance < BigInt.parse(amount)) {
          throw Exception('Allowance not updated. Please try again.');
        }
      }
    } catch (e) {
      print('Error in approvePermit2: $e');
      throw Exception('Failed to approve Permit2: $e');
    }
  }
}

// Define Web3Client
final client = Web3Client(
  "https://mainnet.infura.io/v3/${dotenv.get('INFURA_API_KEY')}",
  http.Client(),
);

// Retry Allowance Check
Future<BigInt> getUpdatedAllowance(
    DeployedContract contract, String spender, String owner) async {
  final allowanceFunction = contract.function('allowance');
  BigInt updatedAllowance = BigInt.zero;

  for (int i = 0; i < 5; i++) {
    try {
      final result = await client.call(
        contract: contract,
        function: allowanceFunction,
        params: [
          EthereumAddress.fromHex(owner),
          EthereumAddress.fromHex(spender),
        ],
      );
      updatedAllowance = BigInt.parse(result[0].toString());
      if (updatedAllowance > BigInt.zero) {
        break;
      }
    } catch (e) {
      print('Retrying allowance check... Attempt ${i + 1}');
    }
    await Future.delayed(const Duration(seconds: 2));
  }

  return updatedAllowance;
}

void _showSuccesPopup(BuildContext context) {
  var theme = Theme.of(context);
  bool isDarkMode = theme.brightness == Brightness.dark;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
        actionsPadding:
            EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
        backgroundColor: isDarkMode ? lightBlackColor2 : whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48.r),
        ),
        icon: Image.asset(
          isDarkMode
              ? "assets/images/swap_success2.png"
              : "assets/images/swap_success.png",
          height: 180.h,
          width: 186.w,
        ),
        title: Text(
          "Successful Swap!",
          style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? lightGreenColor : orange3),
        ),
        content: Text(
            textAlign: TextAlign.center,
            "Your crypto was swap successfully. You can view more details below.",
            style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: isDarkMode ? whiteColor : blackColor2)),
        actions: [
          isDarkMode
              ? CustomGreenButton(
                  buttonText: "View Details",
                  onPressed: () {
                    Navigator.pop(context);
                    Get.offAll(() => const BottomNavBar());
                  })
              : GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Get.offAll(() => const BottomNavBar());
                  },
                  child: Container(
                    height: 58.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        gradient:
                            const LinearGradient(colors: [orange2, orange1])),
                    child: Center(
                      child: Text(
                        "View Details",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            color: whiteColor),
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: 15.h,
          ),
          CustomLightGreenButton(
              buttonText: "Cancel",
              onPressed: () {
                Navigator.pop(context);
                Get.offAll(() => const BottomNavBar());
              })
        ],
      );
    },
  );
}

void _showFailPopup(
    BuildContext context, String message, Future<void> Function() retryFunction) {
  var theme = Theme.of(context);
  bool isDarkMode = theme.brightness == Brightness.dark;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
        actionsPadding:
            EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
        backgroundColor: isDarkMode ? lightBlackColor2 : whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48.r),
        ),
        icon: Image.asset(
          isDarkMode ? "assets/images/fail2.png" : "assets/images/fail.png",
          height: 180.h,
          width: 186.w,
        ),
        title: Text(
          "Oops.. .Failed!",
          style: GoogleFonts.urbanist(
              fontSize: 24.sp, fontWeight: FontWeight.w700, color: pinkColor),
        ),
        content: Text(
            textAlign: TextAlign.center,
            message,
            style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: isDarkMode ? whiteColor : blackColor2)),
        actions: [
          isDarkMode
              ? CustomGreenButton(
                  buttonText: "Try Again",
                  onPressed: () async {
                    Navigator.pop(context); // Close the dialog
                    await retryFunction(); // Retry the swap
                  })
              : GestureDetector(
                  onTap: () async {
                    Navigator.pop(context); // Close the dialog
                    await retryFunction(); // Retry the swap
                  },
                  child: Container(
                    height: 58.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        gradient:
                            const LinearGradient(colors: [orange2, orange1])),
                    child: Center(
                      child: Text(
                        "Try Again",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            color: whiteColor),
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: 15.h,
          ),
          CustomLightGreenButton(
              buttonText: "Cancel",
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      );
    },
  );
}

Future<void> retryRequest(Function request, {int retries = 3}) async {
  for (int i = 0; i < retries; i++) {
    try {
      await request();
      return;
    } catch (e) {
      if (i == retries - 1) {
        rethrow;
      }
      await Future.delayed(const Duration(seconds: 2));
    }
  }
}

Future<void> waitForTransactionConfirmation(String txHash) async {
  final client = Web3Client(
    "https://mainnet.infura.io/v3/${dotenv.get('INFURA_API_KEY')}",
    http.Client(),
  );

  bool confirmed = false;
  int attempts = 0;
  const int maxAttempts = 60; // Wait for up to 2 minutes
  const Duration checkInterval = Duration(seconds: 2);

  while (!confirmed && attempts < maxAttempts) {
    try {
      final receipt = await client.getTransactionReceipt(txHash);
      if (receipt != null) {
        confirmed = true;
        print('Transaction confirmed! Receipt: $receipt');
        break;
      }
    } catch (e) {
      print('Waiting for confirmation... Attempt ${attempts + 1}');
    }

    await Future.delayed(checkInterval);
    attempts++;
  }

  if (!confirmed) {
    throw Exception('Approval transaction not confirmed. Please try again.');
  }
}










