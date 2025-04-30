import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Security&Privacy/controller/security_and_privacy_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Security&Privacy/view/change_password.dart';
import 'package:lnbg_crypto_wallet_app/Views/Security&Privacy/view/show_private_key.dart';
import 'package:lnbg_crypto_wallet_app/Views/Settings/view/show_secret_phrase.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/reuseable_dropdown.dart';
import 'package:shimmer/shimmer.dart';

class SecurityAndPrivacyView extends StatelessWidget {
  SecurityAndPrivacyView({super.key});
    final SecurityAndPrivacyController controller =
      Get.find<SecurityAndPrivacyController>();
  final walletCreatingController = Get.find<WalletCreatingController>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: const CustomAppBar(title: "Security & Privacy", iconPath: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Obx((){
            return controller.isLoading.value?shimmerLoadingWidget():Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reveal Secret Recovery Phrase",
                style: GoogleFonts.urbanist(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? whiteColor : blackColor2),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Protect your wallet by saving your secret recovery phrase in the saving & various places like on a piece of paper, password manager, and/or the cloud.",
                style: GoogleFonts.urbanist(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? greyColor : greyColor3),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>ShowSeedPhrase());
                },
                child: _buildSectionTitle("Reveal Secret Recovery Phrase", context)),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "Password",
                style: GoogleFonts.urbanist(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? whiteColor : blackColor2),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Choose a strong password to unlock LNBG Wallet app on your devices. If you lose this password, you will need your secret recovery phrase to re-import your wallet.",
                style: GoogleFonts.urbanist(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? greyColor : greyColor3),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>ChangePasswordScreen());
                },
                child: _buildSectionTitle("Change Password", context)),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "Auto-Lock",
                style: GoogleFonts.urbanist(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? whiteColor : blackColor2),
              ),
              SizedBox(height: 10.h),
              Text(
                "Choose the amount of time before the application automatically locks.",
                style: GoogleFonts.urbanist(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? greyColor : greyColor3),
              ),
              SizedBox(height: 15.h),
              ReusableDropdown(
                items: const [
                  "After 5 minutes",
                  "After 10 minutes",
                  "After 15 minutes"
                ],
                selectedValue: controller.selectedlocTime,
                onChanged: (newValue) {
    controller.setSelectedTime(newValue);
  },
              ),
              // SizedBox(
              //   height: 40.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Hide Tokens Without Balance",
              //       style: GoogleFonts.urbanist(
              //           fontSize: 20.sp,
              //           fontWeight: FontWeight.w700,
              //           color: isDarkMode ? whiteColor : blackColor2),
              //     ),
              //     CustomSwitch(isSwitched: controller.isBiometric),
              //   ],
              // ),
             
              // SizedBox(
              //   height: 30.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Unlock with Face ID",
              //       style: GoogleFonts.urbanist(
              //           fontSize: 20.sp,
              //           fontWeight: FontWeight.w700,
              //           color: isDarkMode ? whiteColor : blackColor2),
              //     ),
              //     CustomSwitch(isSwitched: controller.isface),
              //   ],
              // ),
           
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Turn on Remember me",
                    style: GoogleFonts.urbanist(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? whiteColor : blackColor2),
                  ),
                  CustomSwitch(isSwitched: controller.isRemember),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "When remember me is on, anyone with access to your phone can access your LNBG Wallet account.",
                style: GoogleFonts.urbanist(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? greyColor : greyColor3),
              ),
              SizedBox(
                height: 40.h,
              ),
           

// Inside your widget build method

Obx(() {
  if (walletCreatingController.isLoading.value) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 24.sp, // Match text height
        width: 250.w,  // Set to expected text width
        color: Colors.white,
      ),
    );
  } else {
    return Text(
      "Show Private Key for ${walletCreatingController.userName.value}",
      style: GoogleFonts.urbanist(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: isDarkMode ? whiteColor : blackColor2,
      ),
    );
  }
}),

              SizedBox(height: 10.h),
              Obx(() {
  if (walletCreatingController.isLoading.value) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(3, (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Container(
            height: 14.sp,
            width: double.infinity,
            color: Colors.white,
          ),
        )),
      ),
    );
  } else {
    return Text(
      "This is the private key for the current selected wallet account: ${walletCreatingController.userName.value}. Never disclose this key. Anyone with your private key can fully control your account, including transferring away any of your funds.",
      style: GoogleFonts.urbanist(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: isDarkMode ? greyColor : greyColor3,
      ),
    );
  }
})
,
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>ShowPrivateKeyScreen());
                },
                child: _buildSectionTitle("Show Private Key", context)),
              SizedBox(height: 30.h),
              const CustomDivider(),
              // SizedBox(height: 35.h),
              // Text(
              //   "Privacy",
              //   style: GoogleFonts.urbanist(
              //       fontSize: 24.sp,
              //       fontWeight: FontWeight.w700,
              //       color: isDarkMode ? whiteColor : blackColor2),
              // ),
              // SizedBox(
              //   height: 40.h,
              // ),
              // Text(
              //   "Clear Privacy Data",
              //   style: GoogleFonts.urbanist(
              //       fontSize: 20.sp,
              //       fontWeight: FontWeight.w700,
              //       color: isDarkMode ? whiteColor : blackColor2),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text(
              //   "Clear privacy data so all the websites mus request access to view account information again.",
              //   style: GoogleFonts.urbanist(
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w500,
              //       color: isDarkMode ? greyColor : greyColor3),
              // ),
              // SizedBox(
              //   height: 15.h,
              // ),
              // GestureDetector(
              //   onTap: (){
              //     //function to clear privacy data..
              //   },
              //   child: _buildSectionTitle("Clear Privacy Data", context)),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "Clear Browser History",
                style: GoogleFonts.urbanist(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? whiteColor : blackColor2),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Choose this option to clear all your entire browsing history.",
                style: GoogleFonts.urbanist(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? greyColor : greyColor3),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: (){
controller.clearBrowserHistory();
                },
                child: _buildSectionTitle("Clear Browser History", context)),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "Clear Browser Cookies",
                style: GoogleFonts.urbanist(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? whiteColor : blackColor2),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Choose this option to clear all your entire browser cookies.",
                style: GoogleFonts.urbanist(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? greyColor : greyColor3),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: (){
                  controller.clearBrowserCookies();
                },
                child: _buildSectionTitle("Clear Browser Cookies", context)),
              SizedBox(
                height: 40.h,
              ),
             
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Privacy Mode",
              //       style: GoogleFonts.urbanist(
              //           fontSize: 20.sp,
              //           fontWeight: FontWeight.w700,
              //           color: isDarkMode ? whiteColor : blackColor2),
              //     ),
              //     CustomSwitch(isSwitched: controller.isPrivacy),
              //   ],
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text(
              //   "Websites mus request access to view account information again.",
              //   style: GoogleFonts.urbanist(
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w500,
              //       color: isDarkMode ? greyColor : greyColor3),
              // ),
              // SizedBox(
              //   height: 40.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Show Incoming Transactions",
              //       style: GoogleFonts.urbanist(
              //           fontSize: 20.sp,
              //           fontWeight: FontWeight.w700,
              //           color: isDarkMode ? whiteColor : blackColor2),
              //     ),
              //     CustomSwitch(isSwitched: controller.incommingTransections),
              //   ],
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text(
              //   "Third party APIs (Etherscan) are used to show your incoming transactions in the history. Turn off if you don't want us to pull data from those services. ",
              //   style: GoogleFonts.urbanist(
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w500,
              //       color: isDarkMode ? greyColor : greyColor3),
              // ),
              // SizedBox(
              //   height: 40.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Use Phishing Detection",
              //       style: GoogleFonts.urbanist(
              //           fontSize: 20.sp,
              //           fontWeight: FontWeight.w700,
              //           color: isDarkMode ? whiteColor : blackColor2),
              //     ),
              //     CustomSwitch(isSwitched: controller.phishingDetection),
              //   ],
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text(
              //   "Display a warning for phishing domains targeting Ethereum users.",
              //   style: GoogleFonts.urbanist(
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w500,
              //       color: isDarkMode ? greyColor : greyColor3),
              // ),
              // SizedBox(
              //   height: 40.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Enable OpenSea API",
              //       style: GoogleFonts.urbanist(
              //           fontSize: 20.sp,
              //           fontWeight: FontWeight.w700,
              //           color: isDarkMode ? whiteColor : blackColor2),
              //     ),
              //     CustomSwitch(isSwitched: controller.openSeaAPI),
              //   ],
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text(
              //   "Displaying NFT media & data may expose your IP address to centralized servers. Use OpenSea's API to fetch NFT data. NFT auto-detection relies on OpenSea's API, and will not be available when this is turned off. Enabling NFT auto-detection can expose you to fake NFTs being sent to your wallet by anyone, and can allow an attacker to learn your IP address from your Ethereum address.",
              //   style: GoogleFonts.urbanist(
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w500,
              //       color: isDarkMode ? greyColor : greyColor3),
              // ),
              // SizedBox(
              //   height: 40.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Autodetect NFTs ",
              //       style: GoogleFonts.urbanist(
              //           fontSize: 20.sp,
              //           fontWeight: FontWeight.w700,
              //           color: isDarkMode ? whiteColor : blackColor2),
              //     ),
              //     CustomSwitch(isSwitched: controller.isAutoDectNFT),
              //   ],
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text(
              //   "Displaying NFT media & data may expose your IP address to centralized servers. Third-party APIs (like OpenSea) are used to detect NFTs in your wallet. This exposes your account address with those services. Leave this disabled if you don't want the app to pull data from those services. ",
              //   style: GoogleFonts.urbanist(
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w500,
              //       color: isDarkMode ? greyColor : greyColor3),
              // ),
              // SizedBox(
              //   height: 40.h,
              // ),
              GestureDetector(
                onTap: ()async{
                await  controller.deleteWallet();
                },
                child: Text(
                  "Delete Wallet",
                  style: GoogleFonts.urbanist(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? whiteColor : blackColor2),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "This will remove all wallet related data from your device. Your accounts exist on the blockchain and are not related to LNBG Wallet. You can always recover your accounts using your Secret Recovery Phrase. ",
                style: GoogleFonts.urbanist(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? greyColor : greyColor3),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 45.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: pinkColor, width: 2.h),
                    borderRadius: BorderRadius.circular(100.r)),
                child: Center(
                  child: Text(
                    "Delete Wallet",
                    style: GoogleFonts.urbanist(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: pinkColor),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          );
          })  ),
      ),
    );
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
Widget shimmerLoadingWidget() {
  return Padding(
    padding: EdgeInsets.all(20.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 20.h,
            width: 200.w,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.h),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 14.h,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 15.h),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 45.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
        ),
        SizedBox(height: 40.h),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 20.h,
            width: 150.w,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.h),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 14.h,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 15.h),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 45.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
        ),
        SizedBox(height: 40.h),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 20.h,
            width: 180.w,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.h),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 14.h,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 15.h),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 45.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
        ),
      ],
    ),
  );
}

}
