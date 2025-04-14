


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/confir_send_coin.dart';
import 'package:lnbg_crypto_wallet_app/Views/Transections/controller/transection_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:web3dart/web3dart.dart';

class SendController extends GetxController {
  var ammountController = TextEditingController();
  var addressController = TextEditingController();
  var recipientAddressController = TextEditingController();
  var isAmountEmpty = true.obs; // Reactive variable to track if amount is empty
  var ammountIncrypto = 0.0.obs;
  final walletCreatingCotroller = Get.find<WalletCreatingController>();
  
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

//   Web3Client? client;
  var selectedNetworkSpeed = "Slow".obs; // Default network speed
//   var maxFee = "".obs;
//   var gasLimit = "".obs;
//   var nonce = "".obs;

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

final transactionController = Get.put(TransactionController());
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
  // Function to calculate fees
//   var gasLimit = 21000.obs;
//   void calculateFees({
//     required double cryptoAmount,       // e.g. 0.45
//     required double cryptoAmountInUsd, // e.g. 5.11
//     required double nativeTokenPriceInUsd, // e.g. 1 ETH = 1500 USD
//     required TokenData token,
//   }) {
//     // Gas prices in Gwei
//     const slowGasPriceGwei = 20;
//     const moderateGasPriceGwei = 30;
//     const fastGasPriceGwei = 50;

//     // Convert Gwei to ETH
//     double convertGweiToEth(int gwei) => gwei / 1e9;

//     // Convert gas fees in crypto
//     double calcNetworkFeeCrypto(int gasPriceGwei) {
//       return convertGweiToEth(gasPriceGwei) * gasLimit.value;
//     }

//     // Calculate fees for slow
//     final feeSlowCrypto = calcNetworkFeeCrypto(slowGasPriceGwei);
//     networkFeeSlowUsd.value = feeSlowCrypto * nativeTokenPriceInUsd;
//        networkFeeSlowCrypto.value = networkFeeSlowUsd.value / token.priceInUsd;
//     totalFeeSlowUsd.value = cryptoAmountInUsd + networkFeeSlowUsd.value;
//  totalFeeSlowCrypto.value =     totalFeeSlowUsd.value /token.priceInUsd;
//     // Calculate fees for moderate
//     final feeModerateCrypto = calcNetworkFeeCrypto(moderateGasPriceGwei);
//     networkFeeModerateUsd.value = feeModerateCrypto * nativeTokenPriceInUsd;
//      networkFeeModeratecrypto.value = networkFeeModerateUsd.value / token.priceInUsd;
//     totalFeeModerateUsd.value = cryptoAmountInUsd + networkFeeModerateUsd.value;
//  totalFeeModerateCrypto.value =     totalFeeModerateUsd.value /token.priceInUsd;
//     // Calculate fees for fast
//     final feeFastCrypto = calcNetworkFeeCrypto(fastGasPriceGwei);
//     networkFeeFastUsd.value = feeFastCrypto * nativeTokenPriceInUsd;
//         networkFeeFastcrypto.value = networkFeeFastUsd.value / token.priceInUsd;
//     totalFeeFastUsd.value = cryptoAmountInUsd + networkFeeFastUsd.value;
//  totalFeeFastCrypto.value =     totalFeeFastUsd.value /token.priceInUsd;
//     // Max fee in USD based on fast gas
//     maxFeeUsd.value = feeFastCrypto * nativeTokenPriceInUsd;

//        Get.to(() => ConfirmSendCoinScreen(
//               address: addressController.text,
//               token: token,
//             ));
//   }
var gasLimit = 21000.obs;
Future<void> calculateFees({
  required double cryptoAmount,       // e.g. 0.45
  required double cryptoAmountInUsd, // e.g. 5.11
  required double nativeTokenPriceInUsd, // e.g. 1 ETH = 1500 USD
  required TokenData token,
  required String senderAddress,
  required String recipientAddress,
}) async {
  try {
    isLoading(true);
    final sender = EthereumAddress.fromHex(senderAddress);
    final recipient = EthereumAddress.fromHex(recipientAddress);

    final amountInWei = BigInt.from(cryptoAmount * 1e18);

    // Estimate gas limit dynamically from client
    final estimatedGas = await _client.estimateGas(
      sender: sender,
      to: recipient,
      value: EtherAmount.inWei(amountInWei),
    );

    gasLimit.value = estimatedGas.toInt(); // ✅ dynamic gas limit now
    print('Estimated Gas Limit: ${gasLimit.value}');

    // Gas prices in Gwei
    const slowGasPriceGwei = 20;
    const moderateGasPriceGwei = 30;
    const fastGasPriceGwei = 50;

    // Convert Gwei to ETH
    double convertGweiToEth(int gwei) => gwei / 1e9;

    // Convert gas fees in crypto
    double calcNetworkFeeCrypto(int gasPriceGwei) {
      return convertGweiToEth(gasPriceGwei) * gasLimit.value;
    }

    // SLOW
    final feeSlowCrypto = calcNetworkFeeCrypto(slowGasPriceGwei);
    networkFeeSlowUsd.value = feeSlowCrypto * nativeTokenPriceInUsd;
    networkFeeSlowCrypto.value = feeSlowCrypto;
    totalFeeSlowUsd.value = cryptoAmountInUsd + networkFeeSlowUsd.value;
    totalFeeSlowCrypto.value = cryptoAmount + feeSlowCrypto;

    // MODERATE
    final feeModerateCrypto = calcNetworkFeeCrypto(moderateGasPriceGwei);
    networkFeeModerateUsd.value = feeModerateCrypto * nativeTokenPriceInUsd;
    networkFeeModeratecrypto.value = feeModerateCrypto;
    totalFeeModerateUsd.value = cryptoAmountInUsd + networkFeeModerateUsd.value;
    totalFeeModerateCrypto.value = cryptoAmount + feeModerateCrypto;

    // FAST
    final feeFastCrypto = calcNetworkFeeCrypto(fastGasPriceGwei);
    networkFeeFastUsd.value = feeFastCrypto * nativeTokenPriceInUsd;
    networkFeeFastcrypto.value = feeFastCrypto;
    totalFeeFastUsd.value = cryptoAmountInUsd + networkFeeFastUsd.value;
    totalFeeFastCrypto.value = cryptoAmount + feeFastCrypto;

    // Max fee
    maxFeeUsd.value = feeFastCrypto * nativeTokenPriceInUsd;

    Get.to(() => ConfirmSendCoinScreen(
      address: addressController.text,
      token: token,
    ));
  } catch (e) {
    isLoading(false);
    print('❌ Error estimating gas: $e');
    // Handle error or show fallback fee?
  }
  finally{
    isLoading(false);
  }
}



  // Same variables from previous step...
final Web3Client _client = Web3Client(
   "https://mainnet.infura.io/v3/${dotenv.env['INFURA_API_KEY']}", // Ethereum Mainnet
    Client(),
  );

//send that is working fine and i make transections also with it....but commenting to calculate gas limit dynamically instead of static 21000..
// Future<void> sendCoin({
//   required BuildContext context,
//   required String recipientAddress,
//   required double amountToSend, // in ETH
//   required String privateKey,
// }) async {
//   try {
//     isLoading(true);
//     final credentials = EthPrivateKey.fromHex(privateKey);
//     final myAddress = await credentials.extractAddress();
//     print('Sending from: $myAddress');

//     final chainId = 1; // Goerli testnet
//     final gasPrice = await _client.getGasPrice();
//     const gasLimit = 21000;

//     // Convert ETH amount to Wei (BigInt)
//     final amountInWei = BigInt.from(amountToSend * 1e18);

//     final transaction = Transaction(
//       from: myAddress,
//       to: EthereumAddress.fromHex(recipientAddress),
//       gasPrice: gasPrice,
//       maxGas: gasLimit,
//       value: EtherAmount.inWei(amountInWei),
//     );

//     final txHash = await _client.sendTransaction(
//       credentials,
//       transaction,
//       chainId: chainId,
//       fetchChainIdFromNetworkId: false,
//     );

//     print('Transaction sent! Hash: $txHash');

//     // Wait for confirmation
//     TransactionReceipt? receipt;
//     while (receipt == null) {
//       print('⏳ Waiting for confirmation...');
//       await Future.delayed(Duration(seconds: 5));
//       receipt = await _client.getTransactionReceipt(txHash);
//     }

//     print('✅ Transaction confirmed in block ${receipt.blockNumber}');
//     walletCreatingCotroller.getBalanceInUSD(walletCreatingCotroller.wallwtAddress.value);
//     _showSuccesPopup(context);
//   } catch (e) {
//     isLoading(false);
//     _showFailPopup(context, e.toString());
//     print('❌ Error sending transaction: $e');
//   }
//   finally{
//     isLoading(false);
//   }
// }

Future<void> sendCoin({
  required BuildContext context,
  required String recipientAddress,
  required double amountToSend, // in ETH
  required String privateKey,
  required TokenData token
}) async {
  try {
    isLoading(true);
    final credentials = EthPrivateKey.fromHex(privateKey);
    final myAddress = await credentials.extractAddress();
    print('Sending from: $myAddress');

    final chainId = 1; // Mainnet = 1, Goerli = 5
    final gasPrice = await _client.getGasPrice();

    // Convert ETH to Wei
    final amountInWei = BigInt.from(amountToSend * 1e18);

    // Create a draft transaction for gas estimation
    final draftTransaction = Transaction(
      from: myAddress,
      to: EthereumAddress.fromHex(recipientAddress),
      gasPrice: gasPrice,
      value: EtherAmount.inWei(amountInWei),
    );

    // 🔍 Dynamically estimate gas limit
    final estimatedGas = await _client.estimateGas(
      sender: myAddress,
      to: EthereumAddress.fromHex(recipientAddress),
      value: EtherAmount.inWei(amountInWei),
      data: draftTransaction.data,
    );
    print('⛽ Estimated Gas Limit: $estimatedGas');

    // Create the final transaction with estimated gas
    final transaction = draftTransaction.copyWith(
      maxGas: estimatedGas.toInt(),
    );

    final txHash = await _client.sendTransaction(
      credentials,
      transaction,
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

    print('✅ Transaction confirmed in block ${receipt.blockNumber}');
    walletCreatingCotroller.getBalanceInUSD(walletCreatingCotroller.wallwtAddress.value);
    _showSuccesPopup(context);
    print("txhas is $txHash");
     print("method is send");
      print("time is ${DateTime.now().toIso8601String()}");
       print("from is ${walletCreatingCotroller.wallwtAddress.value}");
        print("to is $recipientAddress");
         print("amount is $amountToSend");
          print("fee is ${EtherAmount.fromUnitAndValue(EtherUnit.ether, (networkFeeSlowCrypto.value * 1e18).toInt()).getValueInUnit(EtherUnit.ether)}");
           print("token is ${ token.symbol.toUpperCase()}");
            print("txhas is $txHash");
             print("txhas is $txHash");
    transactionController.postTransaction(
  walletAddress: walletCreatingCotroller.wallwtAddress.value,
  hash: txHash,
  method: "send",
  time: DateTime.now().toIso8601String(),
  from: walletCreatingCotroller.wallwtAddress.value,
  to: recipientAddress,
  amount: amountToSend,
 fee: selectedNetworkSpeed.value == 'Slow'?networkFeeSlowCrypto.value:selectedNetworkSpeed.value == 'Moderate'
        ?networkFeeModeratecrypto.value:networkFeeFastcrypto.value,
   
  token: token.symbol.toUpperCase(),
  fromToken: "",
  toToken: "",
);


  } catch (e) {
    isLoading(false);
    _showFailPopup(context, e.toString());
    print('❌ Error sending transaction: $e');
  } finally {
    isLoading(false);
  }
}





//  Future<void> sendCrypto({
//   required BuildContext context,
//   required String senderPrivateKey,
//   required String recipientAddress,
//   required double amountToSend,
//   required int gasLimit,
//   required int gasPriceGwei,
//   required String contractAddress,
//   bool isToken = false,
// }) async {
//   try {
//     isLoading(true);

//     final credentials = EthPrivateKey.fromHex(senderPrivateKey);
//     final senderAddress = await credentials.extractAddress();
//     final nonce = await _client.getTransactionCount(senderAddress);
//     final gasPrice = EtherAmount.inWei(BigInt.from(gasPriceGwei * 1e9));

//     String txHash;

//     if (isToken) {
//       // For ERC20 Token Transfer
//       final contract = DeployedContract(
//         ContractAbi.fromJson(_erc20Abi, 'ERC20'),
//         EthereumAddress.fromHex(contractAddress),
//       );
//       final transferFunction = contract.function('transfer');

//       final tx = Transaction.callContract(
//         contract: contract,
//         function: transferFunction,
//         parameters: [
//           EthereumAddress.fromHex(recipientAddress),
//           BigInt.from(amountToSend * pow(10, 18)), // Adjust decimals
//         ],
//         maxGas: gasLimit,
//         gasPrice: gasPrice,
//         nonce: nonce,
//       );

//       txHash = await _client.sendTransaction(
//         credentials,
//         tx,
//         chainId: 1, // MAINNET (set your correct chainId)
//         fetchChainIdFromNetworkId: false,
//       );
//     } else {
//       // Native transfer (e.g., ETH)
//       final tx = Transaction(
//         to: EthereumAddress.fromHex(recipientAddress),
//         value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amountToSend),
//         gasPrice: gasPrice,
//         maxGas: gasLimit,
//         nonce: nonce,
//       );

//       txHash = await _client.sendTransaction(
//         credentials,
//         tx,
//         chainId: 1, // MAINNET
//         fetchChainIdFromNetworkId: false,
//       );
//     }

//     print("Transaction sent! Hash: $txHash");

//     await walletCreatingCotroller.getBalanceInUSD(walletCreatingCotroller.wallwtAddress.value);

//     _showSuccesPopup(context);
//   } catch (e) {
//     print("Error sending transaction: $e");
//     _showFailPopup(context, e.toString());
//   } finally {
//     isLoading(false);
//   }
// }
//  // ERC20 ABI (for token transfers)
 
 

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




}
















