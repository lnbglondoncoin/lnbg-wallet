


// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart';
// import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
// import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
// import 'package:lnbg_crypto_wallet_app/Views/Send/view/confir_send_coin.dart';
// import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
// import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
// import 'package:web3dart/web3dart.dart';

// class SendController extends GetxController {
//   var ammountController = TextEditingController();
//   var addressController = TextEditingController();
//   var recipientAddressController = TextEditingController();
//   var isAmountEmpty = true.obs; // Reactive variable to track if amount is empty
//   var ammountIncrypto = 0.0.obs;
//   final walletCreatingCotroller = Get.find<WalletCreatingController>();
  
//   // Listen to changes in the text field
//   void updateAmount(String value, double coinPrice) {
//     isAmountEmpty.value = ammountController.text.isEmpty; // Update based on controller value
//     // Convert string to double safely
//     ammountIncrypto.value = double.tryParse(value) ?? 0.0;
//     updateConversion(coinPrice, ammountIncrypto.value);
//   }

// // //   final String rpcUrlSepolia = "https://sepolia.infura.io/v3/${dotenv.env['INFURA_API_KEY']}";

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     client = Web3Client(rpcUrlSepolia, Client());
// //   }

//   var enableTextFeild = false.obs;
//   var isEditClicked = false.obs;

//   var selectedSpeed = 0.obs;
//   void changeSelectedSpeed(index, String networkSpeed, TokenData token) {
//     selectedSpeed.value = index;

//     selectedNetworkSpeed.value = networkSpeed;
   
//   }

// //   Web3Client? client;
//   var selectedNetworkSpeed = "Slow".obs; // Default network speed
// //   var maxFee = "".obs;
// //   var gasLimit = "".obs;
// //   var nonce = "".obs;

//   var ammountInUSD = 0.0.obs;
//   // 🔹 Update USD conversion
//   void updateConversion(double coinPrice, double cryptoAmmount) {
//     ammountInUSD.value = cryptoAmmount * coinPrice;
//   }

// //   var fastNetworkFee = "0.0".obs;
// //   var fastNetworkFeeUSD = "0.0".obs;
// //   var moderateNetworkFee = "0.0".obs;
// //   var moderateNetworkFeeUsd = "0.0".obs;
// //   var networkFee = "0.0".obs;
// //   var networkFeeUsd = "0.0".obs;

// //   var totalAmount = "0.0".obs;
// //   var totalAmountUsd = "0.0".obs;

// //   var totalAmountModerate = "0.0".obs;
// //   var totalAmountModerateUsd = "0.0".obs;

// //   var totalAmountFast = "0.0".obs;
// //   var totalAmountUsdFast = "0.0".obs;

//   final sendFormKey = GlobalKey<FormState>();
// var isLoading=false.obs;
//   // Add validation methods
//   String? validateAddress(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Recipient address is required';
//     } else if (!RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(value)) {
//       return "Invalid Ethereum address format";
//     }
//     return null;
//   }

//   String? validateAmount(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Amount is required';
//     }
//     if (value == '0' || double.parse(value) == 0) {
//       return 'Amount cannot be zero';
//     }
//     return null;
//   }

//   // Method to check if form is valid
//   bool validateForm() {
//     return sendFormKey.currentState?.validate() ?? false;
//   }

// //   Future<void> fetchTransactionParams(TokenData token, bool isOkClicked) async {
// //     try {
// //       final credentials = EthPrivateKey.fromHex(walletCreatingCotroller.privateKey!);
// //       final senderAddress = await credentials.extractAddress();

// //       // Get Base Gas Price
// //       EtherAmount baseGasPrice = await client!.getGasPrice();

// //       // Adjust gas price based on selected network speed
// //       EtherAmount adjustedGasPrice;
// //       BigInt baseGasLimit;

// //       // Get base gas limit estimation
// //       EthereumAddress recipient = EthereumAddress.fromHex(addressController.text);
// //       BigInt amountInCrypto = BigInt.from(ammountIncrypto.value);

// //       // Get base gas limit
// //       baseGasLimit = await client!.estimateGas(
// //         sender: senderAddress,
// //         to: recipient,
// //         value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amountInCrypto),
// //       );

// //       // Adjust both gas price and gas limit based on network speed
// //       switch (selectedNetworkSpeed.value) {
// //         case "Moderate":
// //           adjustedGasPrice = EtherAmount.fromBigInt(EtherUnit.wei,
// //               (baseGasPrice.getInWei * BigInt.from(150)) ~/ BigInt.from(100));
// //           baseGasLimit = (baseGasLimit * BigInt.from(120)) ~/ BigInt.from(100);
// //           break;
// //         case "Fast":
// //           adjustedGasPrice = EtherAmount.fromBigInt(EtherUnit.wei, baseGasPrice.getInWei * BigInt.from(2));
// //           baseGasLimit = (baseGasLimit * BigInt.from(140)) ~/ BigInt.from(100);
// //           break;
// //         default: // "Slow"
// //           adjustedGasPrice = baseGasPrice;
// //           break;
// //       }

// //       maxFee.value = adjustedGasPrice.getValueInUnit(EtherUnit.gwei).toStringAsFixed(2);
// //       gasLimit.value = baseGasLimit.toString();

// //       // Fetch Nonce (Transaction Count)
// //       int txCount = await client!.getTransactionCount(senderAddress);
// //       nonce.value = txCount.toString();

// //       if (isOkClicked) {
// //         Get.to(() => ConfirmSendCoinScreen(
// //               address: addressController.text,
// //               token: token,
// //             ));
// //       }
// //     } catch (e) {
// //       Get.snackbar("Error", "Fetching transaction params failed: $e");
// //     }
// //   }

// // Future<void> calculateNetworkFee(
// //     String speed,
// //     TokenData token,
// //     bool isSpeedSelected,
// //   ) async {
// //     try {
// //       isLoading(true);

// //       // Get the base gas price for Ethereum (this can be adjusted based on the token you're using)
// //       EtherAmount baseGasPrice = await client!.getGasPrice();
      
// //       // Standard estimated gas limit for Ethereum transactions (this is a common value)
// //       BigInt estimatedGasLimit = BigInt.from(21000); // Can be adjusted for specific token types

// //       // Calculate base fee in wei (Ethereum's smallest unit)
// //       BigInt baseFeeInWei = baseGasPrice.getInWei * estimatedGasLimit;

// //       // Convert the base fee from wei to the token unit (e.g., Chainlink or other ERC20 token)
// //       double tokenDecimalsFactor = 1 / (pow(10, 18)); // Adjusted for the token's decimals
// //       double baseFeeInToken = baseFeeInWei.toDouble() * tokenDecimalsFactor;

// //       // Convert base fee in token to USD using the token's current price
// //       double baseFeeInUsd = baseFeeInToken * token.priceInUsd;

// //       // Set network fee values based on the speed (slow, moderate, fast)
// //       // Slow (Base fee)
// //       networkFee.value = baseFeeInToken.toString();
// //       networkFeeUsd.value = baseFeeInUsd.toString();
// //       totalAmount.value = (ammountIncrypto.value + baseFeeInToken).toString();
// //       totalAmountUsd.value = (ammountInUSD.value + baseFeeInUsd).toString();

// //       // Moderate (1.5x of base fee)
// //       BigInt moderateFeeWei = (baseFeeInWei * BigInt.from(3)) ~/ BigInt.from(2);
// //       double moderateFeeToken = moderateFeeWei.toDouble() * tokenDecimalsFactor;
// //       double moderateFeeUsd = moderateFeeToken * token.priceInUsd;
// //       moderateNetworkFee.value = moderateFeeToken.toString();
// //       moderateNetworkFeeUsd.value = moderateFeeUsd.toString();
// //       totalAmountModerate.value = (ammountIncrypto.value + moderateFeeToken).toString();
// //       totalAmountModerateUsd.value = (ammountInUSD.value + moderateFeeUsd).toString();

// //       // Fast (2x of base fee)
// //       BigInt fastFeeWei = baseFeeInWei * BigInt.from(2);
// //       double fastFeeToken = fastFeeWei.toDouble() * tokenDecimalsFactor;
// //       double fastFeeUsd = fastFeeToken * token.priceInUsd;
// //       fastNetworkFee.value = fastFeeToken.toString();
// //       fastNetworkFeeUSD.value = fastFeeUsd.toString();
// //       totalAmountFast.value = (ammountIncrypto.value + fastFeeToken).toString();
// //       totalAmountUsdFast.value = (ammountInUSD.value + fastFeeUsd).toString();

// //       // If the speed is not selected, fetch transaction parameters and recalculate
// //       if (!isSpeedSelected) {
// //         await fetchTransactionParams(token, true);
// //       } else {
// //         Get.back();
// //       }
// //     } catch (e) {
// //       // Handle any errors that may occur during the calculation
// //       Get.snackbar("Error", "Calculating network fee failed: $e");
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
 
 
// //  var isLoading = false.obs;
// //   Future<void> sendCrypto(BuildContext context) async {
// //     try {
// //       isLoading(true);
// //       final credentials = EthPrivateKey.fromHex(walletCreatingCotroller.privateKey!);
// //       final senderAddress = await credentials.extractAddress();
// //       final recipientAddress = EthereumAddress.fromHex(addressController.text);
// //       final amountInCrypto = EtherAmount.fromUnitAndValue(EtherUnit.ether, ammountIncrypto.value);
// //       final transaction = Transaction(
// //         to: recipientAddress,
// //         from: senderAddress,
// //         value: amountInCrypto,
// //       );
// //       await client!.sendTransaction(credentials, transaction);
// //       Get.snackbar("Success", "Transaction sent successfully!");
// //     } catch (e) {
// //       Get.snackbar("Error", "Sending transaction failed: $e");
// //     } finally {
// //       isLoading(false);
// //     }
// //   }






//   // // Observables
//   // var selectedCrypto = 'Chainlink'.obs;
//   // var cryptoPriceInUsd = 11.9.obs; // 1 Chainlink = $11.9

//   var gasLimit = 22000.obs;
// var nonce="".obs;
//   var networkFeeSlowUsd = 0.0.obs;
//   var networkFeeModerateUsd = 0.0.obs;
//   var networkFeeFastUsd = 0.0.obs;
//   var networkFeeSlowCrypto = 0.0.obs;
//   var networkFeeModeratecrypto = 0.0.obs;
//   var networkFeeFastcrypto = 0.0.obs;
//   var totalFeeSlowUsd = 0.0.obs;
//   var totalFeeModerateUsd = 0.0.obs;
//   var totalFeeFastUsd = 0.0.obs;
// var totalFeeSlowCrypto = 0.0.obs;
//   var totalFeeModerateCrypto= 0.0.obs;
//   var totalFeeFastCrypto = 0.0.obs;
//   var maxFeeUsd = 0.0.obs;
// var maxFeeCrypto = 0.0.obs;
//   // Function to calculate fees
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




//   // Same variables from previous step...

//   final Web3Client _client = Web3Client(
//     "https://sepolia.infura.io/v3/${dotenv.env['INFURA_API_KEY']}", // replace for testnet or mainnet
//     Client(),
//   );

//   // Send crypto function
// Future<void> sendCrypto({
//   required BuildContext context,
//   required String senderPrivateKey,
//   required String recipientAddress,
//   required double amountToSend, // in crypto (e.g., 0.45 LINK)
//   required int gasLimit,
//   required int gasPriceGwei,
//   required String contractAddress, // if using ERC20
//   bool isToken = false, // set true for ERC20 transfers
// }) async {
//   try {
//     isLoading(true);
//     print(senderPrivateKey);
//     print(recipientAddress);
//     print(amountToSend);
//     print(gasLimit);
//     print(gasPriceGwei);
//     print(contractAddress);

//     final credentials = EthPrivateKey.fromHex(senderPrivateKey);
//     final senderAddress = await credentials.extractAddress();
//     final nonce = await _client.getTransactionCount(senderAddress);
//     final gasPrice = EtherAmount.inWei(BigInt.from(gasPriceGwei * 1e9)); // Gwei to Wei

//     if (isToken) {
//       // Sending ERC20 Token
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
//           BigInt.from(amountToSend * 1e18),
//         ],
//         maxGas: gasLimit,
//         gasPrice: gasPrice,
//         nonce: nonce,
//       );

//       await _client.sendTransaction(
//         credentials,
//         tx,
//         chainId: null,
//         fetchChainIdFromNetworkId: true,
//       );

//     } else {
//       // Native crypto (e.g., ETH, BNB, MATIC)
//       final tx = Transaction(
//         to: EthereumAddress.fromHex(recipientAddress),
//         value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amountToSend),
//         gasPrice: gasPrice,
//         maxGas: gasLimit,
//         nonce: nonce,
//       );

//       await _client.sendTransaction(
//         credentials,
//         tx,
//         chainId: null,
//         fetchChainIdFromNetworkId: true,
//       );
//     }

//    _showSuccesPopup(context);
//   } catch (e) {
//     isLoading(false);
//     _showFailPopup(context,e.toString());
//   } finally {
//     isLoading(false);
//   }
// }
//  static const String _erc20Abi = '''
// [
//   {
//     "constant": false,
//     "inputs": [
//       {
//         "name": "_to",
//         "type": "address"
//       },
//       {
//         "name": "_value",
//         "type": "uint256"
//       }
//     ],
//     "name": "transfer",
//     "outputs": [
//       {
//         "name": "",
//         "type": "bool"
//       }
//     ],
//     "type": "function"
//   }
// ]
// ''';




//    void _showSuccesPopup(BuildContext context) {
//     var theme = Theme.of(context);
//     bool isDarkMode = theme.brightness == Brightness.dark;
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           contentPadding:
//               EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
//           actionsPadding:
//               EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
//           backgroundColor: isDarkMode ? lightBlackColor2 : whiteColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(48.r),
//           ),
//           icon: Image.asset(
//             isDarkMode
//                 ? "assets/images/success21.png"
//                 : "assets/images/success2.png",
//             height: 180.h,
//             width: 186.w,
//           ),
//           title: Text(
//             "Successful Sent!",
//             style: GoogleFonts.urbanist(
//                 fontSize: 24.sp,
//                 fontWeight: FontWeight.w700,
//                 color: isDarkMode ? lightGreenColor : orange3),
//           ),
//           content: Text(
//               textAlign: TextAlign.center,
//               "Your crypto was sent successfully. You can view transaction below.",
//               style: GoogleFonts.urbanist(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w400,
//                   color: isDarkMode ? whiteColor : blackColor2)),
//           actions: [
//             isDarkMode
//                 ? CustomGreenButton(
//                     buttonText: "View Details",
//                     onPressed: () {
//                       Navigator.pop(context);
//                     })
//                 : GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       height: 58.h,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100.r),
//                           gradient:
//                               const LinearGradient(colors: [orange2, orange1])),
//                       child: Center(
//                         child: Text(
//                           "View Details",
//                           style: GoogleFonts.urbanist(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 18.sp,
//                               color: whiteColor),
//                         ),
//                       ),
//                     ),
//                   ),
//             SizedBox(
//               height: 15.h,
//             ),
//             CustomLightGreenButton(
//                 buttonText: "Cancel",
//                 onPressed: () {
//                   Navigator.pop(context);
//                 })
//           ],
//         );
//       },
//     );
//   }

//   void _showFailPopup(BuildContext context, String message) {
//     var theme = Theme.of(context);
//     bool isDarkMode = theme.brightness == Brightness.dark;
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           contentPadding:
//               EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
//           actionsPadding:
//               EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
//           backgroundColor: isDarkMode ? lightBlackColor2 : whiteColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(48.r),
//           ),
//           icon: Image.asset(
//             isDarkMode ? "assets/images/fail2.png" : "assets/images/fail.png",
//             height: 180.h,
//             width: 186.w,
//           ),
//           title: Text(
//             "Oops.. .Failed!",
//             style: GoogleFonts.urbanist(
//                 fontSize: 24.sp, fontWeight: FontWeight.w700, color: pinkColor),
//           ),
//           content: Text(
//               textAlign: TextAlign.center,
//               message,
//               style: GoogleFonts.urbanist(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w400,
//                   color: isDarkMode ? whiteColor : blackColor2)),
//           actions: [
//             isDarkMode
//                 ? CustomGreenButton(
//                     buttonText: "Try Again",
//                     onPressed: () {
//                       Navigator.pop(context);
//                     })
//                 : GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       height: 58.h,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100.r),
//                           gradient:
//                               const LinearGradient(colors: [orange2, orange1])),
//                       child: Center(
//                         child: Text(
//                           "Try Again",
//                           style: GoogleFonts.urbanist(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 18.sp,
//                               color: whiteColor),
//                         ),
//                       ),
//                     ),
//                   ),
//             SizedBox(
//               height: 15.h,
//             ),
//             CustomLightGreenButton(
//                 buttonText: "Cancel",
//                 onPressed: () {
//                   Navigator.pop(context);
//                 })
//           ],
//         );
//       },
//     );
//   }


// }




