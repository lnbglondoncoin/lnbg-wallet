import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_textfeild.dart';

class AddNewCardScreen extends StatelessWidget {
  const AddNewCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar:  CustomAppBar(
        title: "Add New Card".tr,
        iconPath: scanIcon,
        isSuffix: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  children: [
                    CustomTextField2(
                      hintText: '7648 4737 4840 2799',
                      controller: TextEditingController(),
                      labelText: 'Card Number'.tr,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    CustomTextField2(
                      hintText: 'Andrew Ainsley'.tr,
                      controller: TextEditingController(),
                      labelText: 'Card Name'.tr,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    CustomTextField2(
                      hintText: '7648 4737 4840 2799',
                      controller: TextEditingController(),
                      labelText: 'Expiration Date'.tr,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    CustomTextField2(
                      hintText: '12/26/2025',
                      controller: TextEditingController(),
                      labelText: 'Expiration Date'.tr,
                      isSuffix: true,
                      suffixiconPath: "assets/icons/calendar.svg",
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    CustomTextField2(
                      hintText: '755',
                      controller: TextEditingController(),
                      labelText: '755CVV'.tr,
                      isNumber: true,
                    )
                  ],
                ),
              ),
              const Spacer(),
              const CustomDivider(),
              SizedBox(
                height: 200.h,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(20.h),
        child: isDarkMode
            ? CustomGreenButton(
                buttonText: "Continue".tr,
                onPressed: () {
                  _showSuccesPopup(context);
                })
            : CustomButton(
                buttonText: "Continue".tr,
                onPressed: () {
                  _showSuccesPopup(context);
                }),
      ),
    );
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
                ? "assets/images/buysuccess2.png"
                : "assets/images/buysuccess3.png",
            height: 180.h,
            width: 186.w,
          ),
          title: Text(
            "Successful Purchase!",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? lightGreenColor : orange3),
          ),
          content: Text(
              textAlign: TextAlign.center,
              "Purchase Success! Crypto has been added to your wallet.",
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
}
