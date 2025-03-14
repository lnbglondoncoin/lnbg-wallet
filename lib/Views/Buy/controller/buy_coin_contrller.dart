import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/app_constants.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/buy_request_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class CurrencyController extends GetxController {
  var selectedCurrency = 'USD'.obs;
  var amountController = TextEditingController();
  var amount = 0.0.obs;
 
  RxString selectedProvider = "Binance Connect".obs;
    RxString providerImage = "".obs;
  

  @override
  void onInit() {
    super.onInit();
    // Listen to text changes and update amount in real time
    amountController.addListener(() {
      amount.value = amountController.text as double;
    });
  
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }

  final walletCreatingController=Get.find<WalletCreatingController>();



   // MoonPay API Key
  // final String moonPayApiKey = "pk_live_TUWCdKK7nE88Oej7HkW9uCKwyziIr73k";
final String moonPayBaseUrl = "https://buy.moonpay.com";
 // final String moonPayBaseUrl = "https://sandbox.moonpay.com";
  // Selected coin
  // RxString selectedCoin = "ETH".obs; // Default is Ethereum
  RxDouble usdAmount = 0.0.obs;
  RxDouble cryptoAmount = 0.0.obs;
  
  // // Payment methods list
  // List<String> paymentMethods = [
  //   "MoonPay",
  //   "Google Pay",
  //   "Ramp",
  //   "Credit/Debit Card",
  //   "PayPal",
  //   "Binance",
  // ];
  
  // RxString selectedPaymentMethod = "MoonPay".obs;

  // // User's wallet address (Replace this dynamically)
  // final String walletAddress = "USER_WALLET_ADDRESS";

  // Convert USD to Crypto using MoonPay API
  var isLoading=false.obs;

 //   cryptoAmount.value = usdAmount.value / cryptoPrice;
  void updateAmount(String value,double coinPrice,) {
 
          // Convert string to double safely
 usdAmount.value = double.tryParse(value) ?? 0.0;
      cryptoAmount.value = usdAmount.value / coinPrice;
  }

  String get moonPayApiKey => const String.fromEnvironment('MOONPAY_API_KEY', defaultValue: '');
  // Open MoonPay Checkout
Future<void> buyCrypto(String selectedCoin) async {
  isLoading.value = true;
  try {
    // Construct the URL with all required parameters
    final String moonPayUrl = Uri.https('buy.moonpay.com', '', {
      'apiKey': moonPayApiKey,
      'walletAddress': walletCreatingController.wallwtAddress.value,
      'currencyCode': selectedCoin.toLowerCase(), // Make sure it's lowercase
      'baseCurrencyCode': 'usd',
      'baseCurrencyAmount': usdAmount.value.toStringAsFixed(2),
      'showWalletAddressForm': 'false', // Prevent wallet address modification
      'colorCode': '#F5841F', // Optional: customize the widget color
    }).toString();

    print('MoonPay URL: $moonPayUrl'); // Debug print

    if (await canLaunchUrl(Uri.parse(moonPayUrl))) {
      await launchUrl(
        Uri.parse(moonPayUrl), 
        mode: LaunchMode.externalApplication
      );
    } else {
      Get.snackbar("Error", "Could not open MoonPay");
    }
  } catch (e) {
    print('Error launching MoonPay: $e');
    Get.snackbar("Error", "Failed to launch MoonPay: $e");
  } finally {
    isLoading.value = false;
  }
}



// "https://buy.moonpay.com/?apiKey=pk_live_TUWCdKK7nE88OeJ7HkW9uCKwyzilr73k&walletAddress=0x9bc19bf84a92340142fae1f7d7d1af938750c4cc&currencyCode=XRP&baseCurrencyCode=usd&baseCurrencyAmount=5.0";
    void _showSuccesPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon: Image.asset(
            "assets/images/buySuccess.png",
            height: 180.h,
            width: 186.w,
          ),
          title: Text(
            "Successful Purchase!",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp, fontWeight: FontWeight.w700, color: orange3),
          ),
          content: Text(
              textAlign: TextAlign.center,
              "Purchase Success! Crypto has been added to your wallet.",
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: blackColor2)),
          actions: [
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


}
