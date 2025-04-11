import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/wallet_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_checkbox.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_step_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_textfeild.dart';

class CreateNewWallet extends StatelessWidget {
  CreateNewWallet({super.key});
  final StepController controller = Get.put(StepController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: CustomStepAppBar(
        onBackTap: () {
          Get.back();
        },
        currentIndex: controller.currentIndex,
        onWillPop: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          key: controller.passwordKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 25.h, left: 18.w, right: 18.w, bottom: 20.h),
                child: Column(
                  children: [
                    const CustomDivider(),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Create Password",
                      style: GoogleFonts.urbanist(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          color: orange3),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "This password will unlock your LNBG Wallet wallet only on this device.",
                      style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? whiteColor : darkGreyColor),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(
                      isPasswordField: true,
                      hintText: "Password",
                      controller: controller.passController,
                      labelText: "New Password",
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
                      hintText: "Password",
                      controller: controller.confirmPasswordController,
                      labelText: "Confirm New Password",
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
                    SizedBox(
                      height: 20.h,
                    ),
                    const CustomDivider(),
                    SizedBox(
                      height: 30.h,
                    ),
                    Obx(
                      () => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomCheckbox(
                            isChecked: controller.isChecked.value,
                            onChanged: (value) {
                              controller
                                  .toggleCheckbox(!controller.isChecked.value);
                            },
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text:
                                    "I understand that LNBG cannot recover this password for me. ",
                                style: GoogleFonts.urbanist(
                                    color:
                                        isDarkMode ? whiteColor : blackColor2,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800,
                                    height: 1.1.h),
                                children: [
                                  TextSpan(
                                    text: "Learn more",
                                    style: GoogleFonts.urbanist(
                                        color: orange3,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w800,
                                        height: 1.1.h),
                                    // Launch URL or action when clicked
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 1000.h,)
                  ],
                ),
              ),
              const CustomDivider(),
              SizedBox(
                height: 200.h,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        color: isDarkMode ? lightBlackColor3 : whiteColor ,
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.h,bottom: 8.h,top: 15.h),
          child: CustomOrangeButton(
              buttonText: "Create Password",
              onPressed: () {
                controller.isChecked.value
                    ? controller.createPassword()
                    : Get.snackbar(
                        backgroundColor: orange3,
                        snackPosition: SnackPosition.TOP,
                        "Attention",
                        "Please accept terms and conditions");
              }),
        ),
      ),
    );
  }
}
