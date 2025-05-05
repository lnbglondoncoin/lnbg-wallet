import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/ImportWallet/controller/import_from_seed_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/LockApp/controller/lock_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Walkthroughs/view/walkthrough.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_checkbox.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_discription_feild.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_loading_spinner.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_textfeild.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnlockView extends StatelessWidget {
  UnlockView({super.key});
  final AppLockController controller =
      Get.put(AppLockController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: AppBar(
        backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
        shadowColor: isDarkMode ? lightBlackColor3 : whiteColor,
        foregroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
        surfaceTintColor: isDarkMode ? lightBlackColor3 : whiteColor,
        elevation: 0.0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: GestureDetector(
            onTap: (){
                  Get.back();
            },
            child: SizedBox(
                height: 28.h,
                width: 28.w,
                child: Center(
                    child: SvgPicture.asset(
                  arrowLeft,
                  colorFilter: ColorFilter.mode(
                      isDarkMode ? whiteColor : blackColor2, BlendMode.srcIn),
                ))),
          ),
        ),
        title: Text(
          "Unlock Your App",
          style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? whiteColor : blackColor2),
        ),
       
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          key: controller.unlockAppKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 25.h, left: 18.w, right: 18.w, bottom: 20.h),
                child: Column(
                  children: [
                  
                    CustomTextField(
                      isPasswordField: true,
                      hintText: "Password",
                      controller: controller.passController,
                      labelText: "Enter Password",
                      suffixIcoPath: eyeIcon,
                      prefixIconPath: lockIcon,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value.length < 8) {
                          return "Must be at least 8 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomTextField(
                      isPasswordField: true,
                      hintText: "Confirm Password",
                      controller: controller.confirmPasswordController,
                      labelText: "Confirm Password",
                      suffixIcoPath: eyeIcon,
                      prefixIconPath: lockIcon,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm Password cannot be empty";
                        } else if (value != controller.passController.text) {
                          return "Password must be match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    const CustomDivider(),
                    SizedBox(
                      height: 40.h,
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign in with Biometrics?",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: isDarkMode ? whiteColor : blackColor2),
                        ),
                       
                       Obx((){
                        return
                        controller.isSwitched2.value? GestureDetector(
              onTap: () {
                controller.authenticate(context);
              },
              child: SizedBox(
                  height: 28.h,
                  width: 28.w,
                  child: Center(
                      child: SvgPicture.asset(
                    scanIcon,
                    colorFilter: ColorFilter.mode(
                        isDarkMode ? whiteColor : blackColor2, BlendMode.srcIn),
                  ))),
            ):
            CustomOrangeSwitch(isSwitched: controller.isSwitched2);
                       })
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    const CustomDivider(),
                  
                ],
                ),
              ),
             
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
          child: Obx((){
            return  controller.isLoading.value?LoadingSpinner():
           CustomOrangeButton(
                    buttonText: "Unlock",
                    onPressed: () {
                    controller.unlockApp();
                    });
          }) ),
    );
  }
}
