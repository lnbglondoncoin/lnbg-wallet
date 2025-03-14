import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:lnbg_crypto_wallet_app/Constants/app_constants.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/confir_send_coin.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:web3dart/web3dart.dart';

class SendController extends GetxController {
  var ammountController = TextEditingController();
  var addressController = TextEditingController();
  var recipientAddressController = TextEditingController();
  var isAmountEmpty = true.obs; // Reactive variable to track if amount is empty
   var ammountIncrypto=0.0.obs;
  final walletCreatingCotroller=Get.find<WalletCreatingController>();
  // Listen to changes in the text field
  void updateAmount(String value,double coinPrice,) {
    isAmountEmpty.value =
        ammountController.text.isEmpty; // Update based on controller value
          // Convert string to double safely
    ammountIncrypto.value = double.tryParse(value) ?? 0.0;
   updateConversion(coinPrice,ammountIncrypto.value);

  }
 
  final String rpcUrlSepolia = "https://sepolia.infura.io/v3/${dotenv.env['INFURA_API_KEY']}";

  @override
  void onInit() {
    super.onInit();
    // Listen to text changes and update amount in real time
  //   ammountController.addListener(() {
  //     ammountIncrypto.value = ammountController.text as double;
  //   });
        client = Web3Client(rpcUrlSepolia, Client());
  
}
  var enableTextFeild = false.obs;
  var isEditClicked = false.obs;

  var selectedSpeed = 0.obs;
  void changeSelectedSpeed(index,String networkSpeed,TokenData token) {
    selectedSpeed.value = index;
    
   selectedNetworkSpeed.value=networkSpeed; 
   fetchTransactionParams(token,false);// Default network speed
  }


  Web3Client? client;

  // // final selectedCoin = {}.obs;  // Store selected coin details
  // final amountToSend = "".obs;




  var selectedNetworkSpeed = "Slow".obs; // Default network speed
  var maxFee = "".obs;
  var gasLimit = "".obs;
  var nonce = "".obs;

  


var ammountInUSD=0.0.obs;
  // 🔹 Update USD conversion
  void updateConversion(double coinPrice,double cryptoAmmount) {

      ammountInUSD.value=cryptoAmmount* coinPrice;
      
  }
var fastNetworkFee="0.0".obs;
var fastNetworkFeeUSD="0.0".obs;
  var moderateNetworkFee="0.0".obs;
  var moderateNetworkFeeUsd="0.0".obs;
  var networkFee = "0.0".obs;
  var networkFeeUsd = "0.0".obs;
    
  var totalAmount = "0.0".obs;
  var totalAmountUsd = "0.0".obs;
    
  var totalAmountModerate = "0.0".obs;
  var totalAmountModerateUsd = "0.0".obs;
    
  var totalAmountFast = "0.0".obs;
  var totalAmountUsdFast = "0.0".obs;


Future<void> fetchTransactionParams(TokenData token, bool isOkClicked) async {
  try {
    final credentials = EthPrivateKey.fromHex(walletCreatingCotroller.privateKey!);
    final senderAddress = await credentials.extractAddress();

    // Get Base Gas Price
    EtherAmount baseGasPrice = await client!.getGasPrice();
    
    // Adjust gas price based on selected network speed
    EtherAmount adjustedGasPrice;
    BigInt baseGasLimit;
    
    // First get base gas limit estimation
    String inputAddress = "0xa1b2c3d4e5f678901234567890abcdef12345678";
    if (!RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(inputAddress)) {
      throw Exception("Invalid Ethereum address format");
    }
    EthereumAddress recipient = EthereumAddress.fromHex(inputAddress);
    BigInt amountInCrypto = BigInt.from(ammountIncrypto.value);
    
    // Get base gas limit
    baseGasLimit = await client!.estimateGas(
      sender: senderAddress,
      to: recipient,
      value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amountInCrypto),
    );

    // Adjust both gas price and gas limit based on network speed
    switch (selectedNetworkSpeed.value) {
      case "Moderate":
        // 50% faster than base price, 20% higher gas limit for better chances
        adjustedGasPrice = EtherAmount.fromBigInt(
          EtherUnit.wei,
          (baseGasPrice.getInWei * BigInt.from(150)) ~/ BigInt.from(100)
        );
        baseGasLimit = (baseGasLimit * BigInt.from(120)) ~/ BigInt.from(100);
        break;
      case "Fast":
        // 100% faster than base price, 40% higher gas limit for best chances
        adjustedGasPrice = EtherAmount.fromBigInt(
          EtherUnit.wei,
          baseGasPrice.getInWei * BigInt.from(2)
        );
        baseGasLimit = (baseGasLimit * BigInt.from(140)) ~/ BigInt.from(100);
        break;
      default: // "Slow"
        adjustedGasPrice = baseGasPrice;
        // Keep original gas limit for slow transactions
        break;
    }
    
    maxFee.value = adjustedGasPrice.getValueInUnit(EtherUnit.gwei).toStringAsFixed(2);
    gasLimit.value = baseGasLimit.toString();

    // Fetch Nonce (Transaction Count)
    int txCount = await client!.getTransactionCount(senderAddress);
    nonce.value = txCount.toString();

    if(isOkClicked){
      Get.to(() => ConfirmSendCoinScreen(
          address: inputAddress,
          token: token,
        ));
    }
  } catch (e) {
    print("❌ Error: $e");
    Get.snackbar("Error", "Fetching transaction params failed: $e");
  }
}

// 🔹 Estimate network fee for different speeds
Future<void> calculateNetworkFee(String speed, TokenData token, bool isSpeedSelected) async { 
  try {
    EtherAmount gasPrice = await client!.getGasPrice(); // Get gas price
    BigInt estimatedGas = BigInt.from(21000); // Typical gas limit for ETH transfer

    // Perform multiplication using BigInt
    BigInt feeInWei = gasPrice.getInWei * estimatedGas;

    // Convert fee to Ether
    EtherAmount feeInEther = EtherAmount.fromBigInt(EtherUnit.ether, feeInWei);

    // Base fees
    double baseFeeInCoin = feeInEther.getValueInUnit(EtherUnit.ether);
    double baseFeeInUsd = baseFeeInCoin * (token.priceInUsd);

    // Calculate fees for different speeds
    networkFee.value = baseFeeInCoin.toStringAsFixed(2);
    networkFeeUsd.value = baseFeeInUsd.toStringAsFixed(2);
    
    // Moderate speed (1.5x)
    moderateNetworkFee.value = (baseFeeInCoin * 1.5).toStringAsFixed(2);
    moderateNetworkFeeUsd.value = (baseFeeInUsd * 1.5).toStringAsFixed(2);
    
    // Fast speed (2x)
    fastNetworkFee.value = (baseFeeInCoin * 2.0).toStringAsFixed(2);
    fastNetworkFeeUSD.value = (baseFeeInUsd * 2.0).toStringAsFixed(2);

    // Calculate total amounts
    totalAmount.value = (ammountIncrypto.value + baseFeeInCoin).toStringAsFixed(2);
    totalAmountUsd.value = (ammountInUSD.value + baseFeeInUsd).toStringAsFixed(2);
    
    totalAmountModerate.value = (ammountIncrypto.value + (baseFeeInCoin * 1.5)).toStringAsFixed(2);
    totalAmountModerateUsd.value = (ammountInUSD.value + (baseFeeInUsd * 1.5)).toStringAsFixed(2);
    
    totalAmountFast.value = (ammountIncrypto.value + (baseFeeInCoin * 2.0)).toStringAsFixed(2);
    totalAmountUsdFast.value = (ammountInUSD.value + (baseFeeInUsd * 2.0)).toStringAsFixed(2);

    if (!isSpeedSelected) {
      await fetchTransactionParams(token, true);
    } else {
      Get.back();
    }

  } catch (e) {
    Get.snackbar("Error", "calculating network fee: $e");
  }
}

var isLoading=false.obs;
 // 🔹 Send transaction
  Future<void> sendCrypto(BuildContext context) async {
    try {
    
isLoading(true);
      final credentials = EthPrivateKey.fromHex(walletCreatingCotroller.privateKey!);
      final senderAddress = await credentials.extractAddress();

      // Convert amount to BigInt (wei)
      BigInt amountInWei = BigInt.from(ammountIncrypto.value * 1e18); // Convert ETH to Wei

      // Convert gas price to BigInt (wei)
      BigInt gasPriceInWei = BigInt.from(double.parse(maxFee.value) * 1e9); // Convert Gwei to Wei

      final transaction = Transaction(
        from: senderAddress,
        to: EthereumAddress.fromHex("0xa1b2c3d4e5f678901234567890abcdef12345678"),
        value: EtherAmount.fromBigInt(EtherUnit.wei, amountInWei),
        gasPrice: EtherAmount.fromBigInt(EtherUnit.wei, gasPriceInWei),
        maxGas: int.parse(gasLimit.value),
        nonce: int.parse(nonce.value),
      );

      final txHash = await client!.sendTransaction(
        credentials, 
        transaction, 
        chainId: 11155111  // Sepolia testnet chain ID
      );
      
      // Get.snackbar("Transaction Sent", "Tx Hash: $txHash");
      _showSuccesPopup(context);

    } catch (e) {
      isLoading(false);
     _showFailPopup(context, e.toString());
      Get.log(e.toString());
    } finally {
      isLoading(false);
    }
  }


  void _showSuccesPopup(BuildContext context) {
      var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
          backgroundColor:isDarkMode?lightBlackColor2: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon: Image.asset(
           isDarkMode? "assets/images/success21.png": "assets/images/success2.png",
            height: 180.h,
            width: 186.w,
          ),
          title: Text(
            "Successful Sent!",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp, fontWeight: FontWeight.w700, color: isDarkMode?lightGreenColor:orange3),
          ),
          content: Text(
              textAlign: TextAlign.center,
              "Your crypto was sent successfully. You can view transaction below.",
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode?whiteColor: blackColor2)),
          actions: [
         isDarkMode?CustomGreenButton(buttonText: "View Details", onPressed: (){
          Navigator.pop(context);
         }):
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 58.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    gradient: const LinearGradient(colors: [orange2, orange1])),
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

  void _showFailPopup(BuildContext context,String message) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
           backgroundColor:isDarkMode?lightBlackColor2: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon: Image.asset(
           isDarkMode? "assets/images/fail2.png": "assets/images/fail.png",
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
                   color: isDarkMode?whiteColor: blackColor2)),
          actions: [
            isDarkMode?CustomGreenButton(buttonText: "Try Again", onPressed: (){
                Navigator.pop(context);
            }):GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 58.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    gradient: const LinearGradient(colors: [orange2, orange1])),
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
