import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/ImportWallet/controller/import_from_seed_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/ImportWallet/view/finger_print_scan_screen.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_checkbox.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_discription_feild.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_textfeild.dart';

class ImportFromSeedPhraseScreen extends StatelessWidget {
  ImportFromSeedPhraseScreen({super.key});
  final ImportFromSeedController controller =
      Get.put(ImportFromSeedController());

  @override
  Widget build(BuildContext context) {
          var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
     backgroundColor:isDarkMode?lightBlackColor3:whiteColor,
      appBar: AppBar(
        backgroundColor:isDarkMode?lightBlackColor3:whiteColor,
        shadowColor:  isDarkMode?lightBlackColor3:whiteColor,
        foregroundColor:  isDarkMode?lightBlackColor3:whiteColor,
        surfaceTintColor: isDarkMode?lightBlackColor3:whiteColor,
        elevation: 0.0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: SizedBox(
              height: 28.h,
              width: 28.w,
              child: Center(child: SvgPicture.asset(arrowLeft,colorFilter: ColorFilter.mode(isDarkMode?whiteColor:blackColor2, BlendMode.srcIn),))),
        ),
        title: Text(
          "Import From Seed",
          style: GoogleFonts.urbanist(
              fontSize: 24.sp, fontWeight: FontWeight.w700, color: isDarkMode?whiteColor:blackColor2),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: GestureDetector(
              onTap: () {
                controller.authenticate(context);
              },
              child: SizedBox(
                  height: 28.h,
                  width: 28.w,
                  child: Center(child: SvgPicture.asset(scanIcon,colorFilter: ColorFilter.mode(isDarkMode?whiteColor:blackColor2, BlendMode.srcIn),))),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          key: controller.importSeedKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 25.h, left: 18.w, right: 18.w, bottom: 20.h),
                child: Column(
                  children: [
                    CustomDescriptionTextField(
                      hintText: "Seed Phrase",
                      controller: controller.seedPhraseController,
                      labelText: "Seed Phrase",
                      // suffixIcoPath: eyeIcon,
                      //prefixIconPath: eyeIcon,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Seed phrase cannot be empty";
                        } else {
                          // Split the input into words
                          List<String> words = value.trim().split(' ');

                          // Check if the length is exactly 12 words
                          if (words.length != 12) {
                            return "Phrase must consist of exactly 12 words";
                          }

                          // Optionally, check if all words are valid (if necessary)
                          for (var word in words) {
                            if (word.isEmpty) {
                              return "Seed phrase cannot have empty words";
                            }
                          }
                        }
                        return null;
                      },
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
                    const CustomDivider(),
                    SizedBox(
                      height: 35.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign in with Face ID?",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color:isDarkMode?whiteColor: blackColor2),
                        ),
                        CustomOrangeSwitch(isSwitched: controller.isSwitched1),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign in with Biometrics?",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color:isDarkMode?whiteColor: blackColor2),
                        ),
                        CustomOrangeSwitch(isSwitched: controller.isSwitched2),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const CustomDivider(),
                    SizedBox(
                      height: 20.h,
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
                                text: "I agree to LNBG Wallet ",
                                style: GoogleFonts.urbanist(
                                    color: isDarkMode?whiteColor: blackColor2,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800,
                                    height: 1.4.h),
                                children: [
                                  TextSpan(
                                    text: "Term & Conditions.",
                                    style: GoogleFonts.urbanist(
                                        color: orange3,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w800,
                                        height: 1.4.h),
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
              Container(
                height: 1,
                width: double.infinity,
                color: isDarkMode?lightBlackColor: greyColor4,
              ),
              SizedBox(
                height: 200.h,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        child: CustomOrangeButton(
            buttonText: "Import",
            onPressed: () {
              controller.isChecked.value
                  ? controller.import()
                  : Get.snackbar(
                      backgroundColor: orange3,
                      snackPosition: SnackPosition.TOP,
                      "Attention",
                      "Please accept terms and conditions");
            }),
      ),
    );
  }
}
