import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/AdvanceSettings/controller/advance_setting_cntroller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_textfeild.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/reuseable_dropdown.dart';

class AdvanceSettingView extends StatelessWidget {
  AdvanceSettingView({super.key});
  final controller = Get.put(AdvanceSettingCntroller());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
        backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
        appBar:  CustomAppBar(title: "Advanced".tr, iconPath: ""),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "State Logs".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? whiteColor : blackColor2),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "State logs contain your public account addresses and sent transactions.".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? greyColor : greyColor3),
                ),
                SizedBox(
                  height: 15.h,
                ),
                _buildSectionTitle("Download State Logs".tr, context),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Sync with Dekstop".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? whiteColor : blackColor2),
                ),

                SizedBox(
                  height: 15.h,
                ),
                _buildSectionTitle("Sync with Dekstop".tr, context),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "State Logs".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? whiteColor : blackColor2),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "State logs contain your public account addresses and sent transactions.".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? greyColor : greyColor3),
                ),
                SizedBox(
                  height: 15.h,
                ),
                _buildSectionTitle("Download State Logs".tr, context),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Advanced Gas Controls".tr,
                      style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? whiteColor : blackColor2),
                    ),
                    CustomSwitch(isSwitched: controller.gasControl),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Select this to show gas price and limit controls directly on the send and confirm screens.".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? greyColor : greyColor3),
                ),
                SizedBox(
                  height: 30.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Show Hex Data".tr,
                      style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? whiteColor : blackColor2),
                    ),
                    CustomSwitch(isSwitched: controller.haxData),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Select this to show the hex data field on the send screen.".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? greyColor : greyColor3),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Customize Transaction Nonce".tr,
                      style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? whiteColor : blackColor2),
                    ),
                    CustomSwitch(isSwitched: controller.transaction),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Turn this on to change the nonce (transaction number) on confirmation screens. This is an advanced feature, use cautiously.".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? greyColor : greyColor3),
                ),
                SizedBox(
                  height: 30.h,
                ),
                // SizedBox(height: 40.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sync Data with 3Box".tr,
                      style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? whiteColor : blackColor2),
                    ),
                    CustomSwitch(isSwitched: controller.syncData),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Turn on to have your settings backed up with 3Box. This feature is currently experimental; use at your own risk.".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? greyColor : greyColor3),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Dismiss Secret Recovery Phrase Backup Reminder".tr,
                        maxLines: 2,
                        style: GoogleFonts.urbanist(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? whiteColor : blackColor2),
                      ),
                    ),
                    CustomSwitch(isSwitched: controller.dismiss),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Turn this on to dismiss the Secret Recovery Phrase backup reminder message. We highly recommend that you back up your Secret Recovery Phrase to avoid loss of funds.".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? greyColor : greyColor3),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enhanced Token Detection".tr,
                      style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? whiteColor : blackColor2),
                    ),
                    CustomSwitch(isSwitched: controller.tokenDetection),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "We use third-party APIs to detect and display new tokens sent to your wallet. Turn off if you don’t want the app to pull data from those services.".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? greyColor : greyColor3),
                ),
                SizedBox(
                  height: 30.h,
                ),

                Text(
                  "IPFS Gateway".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? whiteColor : blackColor2),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Enter the URL of the IPFS CID gateway to use for ENS content resolution.".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? greyColor : greyColor3),
                ),

                CustomTextField(
                    hintText: "dweb.link".tr,
                    controller: TextEditingController(),
                    labelText: ""),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Preferred Ledger Connection Type".tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? whiteColor : blackColor2),
                ),
                SizedBox(height: 10.h),

                RichText(
                  text: TextSpan(
                    style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: greyColor3,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "Customize how you connect your Ledger to LNBG Wallet. WebHID is recommended, but other options are available. Read more here: ".tr,
                        style: GoogleFonts.urbanist(
                          color: isDarkMode ? greyColor : greyColor3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Learn more",
                        style: GoogleFonts.urbanist(
                          color: isDarkMode ? lightGreenColor : orange3,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle "Learn more" tap here
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                ReusableDropdown(
                  items:  ["WebHID".tr, "WebHID2".tr, "WebHID3".tr],
                  selectedValue: controller.selectedLegerConType,
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Container(
      height: 45.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color: isDarkMode ? lightGreenColor : orange3, width: 2.h),
          borderRadius: BorderRadius.circular(100.r)),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.urbanist(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? lightGreenColor : orange3),
        ),
      ),
    );
  }
}
