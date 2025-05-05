import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/confir_send_coin.dart';
import 'package:lnbg_crypto_wallet_app/Views/Transections/controller/transection_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class SendController extends GetxController {
  var ammountController = TextEditingController();
  var addressController = TextEditingController();
  var recipientAddressController = TextEditingController();
  var isAmountEmpty = true.obs; // Reactive variable to track if amount is empty
  var ammountIncrypto = 0.0.obs;
  final walletCreatingCotroller = Get.find<WalletCreatingController>();
  final transactionController = Get.put(TransactionController());
  // Listen to changes in the text field
  void updateAmount(String value, double coinPrice) {
    isAmountEmpty.value = ammountController.text.isEmpty; // Update based on controller value
    // Convert string to double safely
    ammountIncrypto.value = double.tryParse(value) ?? 0.0;
    updateConversion(coinPrice, ammountIncrypto.value);
  }

@override
  void onInit(){
  super.onInit();
transactionController. fetchTransactions(walletCreatingCotroller.wallwtAddress.value);
}
  var enableTextFeild = false.obs;
  var isEditClicked = false.obs;

  var selectedSpeed = 0.obs;
  void changeSelectedSpeed(index, String networkSpeed, TokenData token) {
    selectedSpeed.value = index;

    selectedNetworkSpeed.value = networkSpeed;
   
  }

  var selectedNetworkSpeed = "Slow".obs; // Default network speed

  var ammountInUSD = 0.0.obs;
  // 🔹 Update USD conversion
  void updateConversion(double coinPrice, double cryptoAmmount) {
    ammountInUSD.value = cryptoAmmount * coinPrice;
  }


  final sendFormKey = GlobalKey<FormState>();
var isLoading=false.obs;
  // Add validation methods
  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Recipient address is required';
    } else if (!RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(value)) {
      return "Invalid Ethereum address format";
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    if (value == '0' || double.parse(value) == 0) {
      return 'Amount cannot be zero';
    }
    return null;
  }

  // Method to check if form is valid
  bool validateForm() {
    return sendFormKey.currentState?.validate() ?? false;
  }

// final transactionController = Get.put(TransactionController());
var nonce="".obs;
  var networkFeeSlowUsd = 0.0.obs;
  var networkFeeModerateUsd = 0.0.obs;
  var networkFeeFastUsd = 0.0.obs;
  var networkFeeSlowCrypto = 0.0.obs;
  var networkFeeModeratecrypto = 0.0.obs;
  var networkFeeFastcrypto = 0.0.obs;
  var totalFeeSlowUsd = 0.0.obs;
  var totalFeeModerateUsd = 0.0.obs;
  var totalFeeFastUsd = 0.0.obs;
var totalFeeSlowCrypto = 0.0.obs;
  var totalFeeModerateCrypto= 0.0.obs;
  var totalFeeFastCrypto = 0.0.obs;
  var maxFeeUsd = 0.0.obs;
var maxFeeCrypto = 0.0.obs;
var gasPriceSlow = 0.0.obs;
var gasPriceModerate = 0.0.obs;
var gasPriceFast = 0.0.obs;
var gasLimit = 21000.obs;

Future<void> calculateFees({
  required double cryptoAmount, // Amount of the token being sent
  required double cryptoAmountInUsd, // Amount in USD
  required double tokenPriceInUSD, // Price of the native token in USD
  required TokenData token,
  required String senderAddress,
  required String recipientAddress,
}) async {
  try {
    isLoading(true);

    final sender = EthereumAddress.fromHex(senderAddress);
    final recipient = EthereumAddress.fromHex(recipientAddress);

    // Determine if the token is native or ERC20
    bool isNativeToken = token.symbol.toUpperCase() == "ETH" || 
    token.symbol.toUpperCase() == "BNB"|| 
    token.symbol.toUpperCase() == "BTC"|| 
    token.symbol.toUpperCase() == "ADA"|| 
    token.symbol.toUpperCase() == "SOL"|| 
    token.symbol.toUpperCase() == "XTZ"|| 
    token.symbol.toUpperCase() == "DOT"|| 
    token.symbol.toUpperCase() == "AVAX"|| 
    token.symbol.toUpperCase() == "TRX"|| 
    token.symbol.toUpperCase() == "ATOM";

    // Fetch real-time gas prices
    final gasPrice = await _client.getGasPrice(); // Fetch current gas price in Wei
    const slowMultiplier = 0.8; // 80% of the current gas price
    const moderateMultiplier = 1.0; // 100% of the current gas price
    const fastMultiplier = 1.2; // 120% of the current gas price

    final gasPriceSlow = gasPrice.getValueInUnit(EtherUnit.gwei) * slowMultiplier;
    final gasPriceModerate = gasPrice.getValueInUnit(EtherUnit.gwei) * moderateMultiplier;
    final gasPriceFast = gasPrice.getValueInUnit(EtherUnit.gwei) * fastMultiplier;

    // Estimate gas limit
    BigInt estimatedGas;
    if (isNativeToken) {
      // Native token transfer
      final amountInWei = BigInt.from(cryptoAmount * 1e18);
      estimatedGas = await _client.estimateGas(
        sender: sender,
        to: recipient,
        value: EtherAmount.fromBigInt(EtherUnit.wei, amountInWei),
      );
    } else {
      // ERC20 token transfer
      const standardErc20Abi = '''
  [
        {
          "constant": false,
          "inputs": [
            {
              "name": "_to",
              "type": "address"
            },
            {
              "name": "_value",
              "type": "uint256"
            }
          ],
          "name": "transfer",
          "outputs": [
            {
              "name": "",
              "type": "bool"
            }
          ],
           "type": "function"
        }
      ]
      ''';

        final contract = DeployedContract(
        ContractAbi.fromJson(standardErc20Abi, token.name),
        EthereumAddress.fromHex(token.contractAddress),
      );
      final transferFunction = contract.function('transfer');
      final data = transferFunction.encodeCall([recipient, BigInt.from(cryptoAmount * 1e18)]);

      // Log the encoded data for debugging
      print('Encoded Data: $data');

      estimatedGas = await _client.estimateGas(
        sender: sender,
        to: EthereumAddress.fromHex(token.contractAddress),
        data: data,
        value: EtherAmount.zero(), // Ensure zero value for ERC20 transfers
      );
    }
    gasLimit.value = estimatedGas.toInt(); // Convert BigInt to int
    print('Estimated Gas Limit: ${gasLimit.value}');

    // Convert Gwei to ETH
    double convertGweiToEth(double gwei) => gwei / 1e9;

    // Calculate network fees for each speed
    double calcNetworkFeeCrypto(double gasPriceGwei) {
      return convertGweiToEth(gasPriceGwei) * gasLimit.value;
    }


     // SLOW
    final feeSlowCrypto = calcNetworkFeeCrypto(gasPriceSlow);
    networkFeeSlowUsd.value = feeSlowCrypto * tokenPriceInUSD;
    networkFeeSlowCrypto.value = feeSlowCrypto;
    totalFeeSlowUsd.value = networkFeeSlowUsd.value + cryptoAmountInUsd;

    // MODERATE
    final feeModerateCrypto = calcNetworkFeeCrypto(gasPriceModerate);
    networkFeeModerateUsd.value = feeModerateCrypto * tokenPriceInUSD;
    networkFeeModeratecrypto.value = feeModerateCrypto;
    totalFeeModerateUsd.value = networkFeeModerateUsd.value + cryptoAmountInUsd;

    // FAST
    final feeFastCrypto = calcNetworkFeeCrypto(gasPriceFast);
    networkFeeFastUsd.value = feeFastCrypto * tokenPriceInUSD;
    networkFeeFastcrypto.value = feeFastCrypto;
    totalFeeFastUsd.value = networkFeeFastUsd.value + cryptoAmountInUsd;

   // Max fee
    maxFeeUsd.value = feeFastCrypto * tokenPriceInUSD;
    maxFeeCrypto.value = feeFastCrypto;

Get.toNamed(
  AppRoutes.confirmSendCoinScreen,
  arguments: {
    'address': addressController.text,
    'token': token,
  },
);

    print('Fees calculated successfully');
  } catch (e) {
     _showFailPopup(Get.context!, e.toString());
    print('❌ Error calculating fees: $e');
  } finally {
    isLoading(false);
  }
}

Future<void> fetchNonce(String senderAddress) async {
  try {
    final sender = EthereumAddress.fromHex(senderAddress);
    final currentNonce = await _client.getTransactionCount(sender);
    nonce.value = currentNonce.toString();
    print('Nonce: $nonce');
  } catch (e) {
    print('❌ Error fetching nonce: $e');
  }
}

bool validateTotalFees(double walletBalance, double totalFeeCrypto) {
  if (walletBalance < totalFeeCrypto) {
    print('❌ Insufficient funds: Wallet balance=$walletBalance, Total fee=$totalFeeCrypto');
    return false;
  }
  return true;
}

  // Same variables from previous step...
final Web3Client _client = Web3Client(
   "https://mainnet.infura.io/v3/${dotenv.env['INFURA_API_KEY']}", // Ethereum Mainnet
    Client(),
  );

Future<void> sendCoin({
  required BuildContext context,
  required String recipientAddress,
  required double amountToSend, // in token
  required String privateKey,
  required TokenData token,
}) async {
  try {
    isLoading(true);
    final credentials = EthPrivateKey.fromHex(privateKey);
    final myAddress = await credentials.extractAddress();
    print('Sending from: $myAddress');

    final chainId = 1; // Mainnet = 1, Goerli = 5
    final gasPrice = await _client.getGasPrice();

    // Determine if the token is native or ERC20
    bool isNativeToken = token.symbol.toUpperCase() == "ETH" || token.symbol.toUpperCase() == "BNB";

    Transaction transaction;
    if (isNativeToken) {
      // Native token transfer
      final amountInWei = BigInt.from(amountToSend * 1e18);
      transaction = Transaction(
        from: myAddress,
        to: EthereumAddress.fromHex(recipientAddress),
        gasPrice: gasPrice,
        value: EtherAmount.fromBigInt(EtherUnit.wei, amountInWei), // Corrected EtherAmount
      );
    } else {
      // ERC20 token transfer
      const standardErc20Abi = '''
      [
        {
          "constant": false,
          "inputs": [
            {
              "name": "_to",
              "type": "address"
            },
            {
              "name": "_value",
              "type": "uint256"
            }
          ],
          "name": "transfer",
          "outputs": [
            {
              "name": "",
              "type": "bool"
            }
          ],
          "type": "function"
        }
      ]
      ''';

      final contract = DeployedContract(
        ContractAbi.fromJson(standardErc20Abi, token.name),
        EthereumAddress.fromHex(token.contractAddress),
      );
      final transferFunction = contract.function('transfer');
      final data = transferFunction.encodeCall([
        EthereumAddress.fromHex(recipientAddress),
        BigInt.from(amountToSend * 1e18)
      ]);

      transaction = Transaction(
        from: myAddress,
        to: EthereumAddress.fromHex(token.contractAddress),
        gasPrice: gasPrice,
       value: EtherAmount.fromBigInt(EtherUnit.wei, BigInt.zero), // Correct usage
        data: data,
      );
    }

    // Dynamically estimate gas limit
    final estimatedGas = await _client.estimateGas(
      sender: myAddress,
      to: transaction.to,
      value: transaction.value,
      data: transaction.data,
    );
    print('⛽ Estimated Gas Limit: $estimatedGas');

    // Create the final transaction with estimated gas
    final finalTransaction = transaction.copyWith(
      maxGas: estimatedGas.toInt(),
    );

    final txHash = await _client.sendTransaction(
      credentials,
      finalTransaction,
      chainId: chainId,
      fetchChainIdFromNetworkId: false,
    );

    print('📤 Transaction sent! Hash: $txHash');

    // Wait for confirmation
    TransactionReceipt? receipt;
    while (receipt == null) {
      print('⏳ Waiting for confirmation...');
      await Future.delayed(Duration(seconds: 5));
      receipt = await _client.getTransactionReceipt(txHash);
    }
     await transactionController.postTransaction(
          walletAddress: walletCreatingCotroller.wallwtAddress.value,
          hash: txHash,
          method: "send",
          time: DateTime.now().toIso8601String(),
          from: walletCreatingCotroller.wallwtAddress.value,
          to: recipientAddress,
          amount: ammountIncrypto.value,
          fee:  selectedNetworkSpeed.value=="Slow"?
                          networkFeeSlowCrypto.value:
                              selectedNetworkSpeed.value=="Moderate"?
                                 networkFeeModeratecrypto.value:
                                networkFeeFastcrypto.value,
                               
          token: token.symbol.toUpperCase(),
          fromToken: token.symbol.toUpperCase(),
          toToken:token.symbol.toUpperCase(),
        );
 // Fetch updated wallet data and transactions
        await walletCreatingCotroller.fetchWalletData(
          walletCreatingCotroller.wallwtAddress.value,
          false,
          false
        );
        await transactionController.fetchTransactions(
          walletCreatingCotroller.wallwtAddress.value
        );
         _showSuccesPopup(context);
    print('✅ Transaction confirmed in block ${receipt.blockNumber}');
   
  } catch (e) {
    _showFailPopup(context, e.toString());
    print('❌ Error sending transaction: $e');
  } finally {
    isLoading(false);
  }
}

   void _showSuccesPopup(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
          backgroundColor: isDarkMode ? lightBlackColor2 : whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon: Image.asset(
            isDarkMode
                ? "assets/images/success21.png"
                : "assets/images/success2.png",
            height: 180.h,
            width: 186.w,
          ),
          title: Text(
            "Successful Sent!",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? lightGreenColor : orange3),
          ),
          content: Text(
              textAlign: TextAlign.center,
              "Your crypto was sent successfully. You can view transaction below.",
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
                    })
                : GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
                })
          ],
        );
      },
    );
  }

  void _showFailPopup(BuildContext context, String message) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
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
                    onPressed: () {
                      Navigator.pop(context);
                    })
                : GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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

  final List<Map<String, dynamic>> transferFunctionAbi = [
    {
      "constant": false,
      "inputs": [
        {
          "name": "_to",
          "type": "address"
        },
        {
          "name": "_value",
          "type": "uint256"
        }
      ],
      "name": "transfer",
      "outputs": [
        {
          "name": "",
          "type": "bool"
        }
      ],
      "type": "function"
    }
  ];




  Future<void> clearTransaction(String walletAddress, String method) async {
    isLoading.value = true;

    final baseUrl = 'http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/transactions';
    final url = Uri.parse('$baseUrl/$walletAddress?method=$method');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        transactionController.fetchTransactions(walletAddress);
        Get.snackbar('Success', 'Transaction deleted successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete transaction: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}









