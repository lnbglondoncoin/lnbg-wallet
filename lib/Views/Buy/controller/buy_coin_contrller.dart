import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CurrencyController extends GetxController {
  var selectedCurrency = 'USD'.obs;
  var amountController = TextEditingController();
  var amount = 0.0.obs;

  RxString selectedProvider = "MoonPay".obs;
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

  final walletCreatingController = Get.find<WalletCreatingController>();
  final String moonPayBaseUrl = "https://buy.moonpay.com";
  RxDouble usdAmount = 0.0.obs;
  RxDouble cryptoAmount = 0.0.obs;
  var isLoading = false.obs;

  void updateAmount(
    String value,
    double coinPrice,
  ) {
    // Convert string to double safely
    usdAmount.value = double.tryParse(value) ?? 0.0;
    cryptoAmount.value = usdAmount.value / coinPrice;
  }

  String get moonPayApiKey =>
      const String.fromEnvironment('MOONPAY_API_KEY', defaultValue: '');
  // Open MoonPay Checkout
  Future<void> buyCrypto(String selectedCoin) async {
   
    try {
       isLoading.value = true;
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

      if (await canLaunchUrl(Uri.parse(moonPayUrl))) {
        await launchUrl(Uri.parse(moonPayUrl),
            mode: LaunchMode.externalApplication);
            
      } else {
        Get.snackbar("Error", "Could not open MoonPay");
      }
    } catch (e) {
            isLoading.value = false;
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
