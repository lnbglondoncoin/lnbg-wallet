  import 'package:flutter/gestures.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_svg/svg.dart';
  import 'package:get/get.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
  import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
  import 'package:lnbg_crypto_wallet_app/Views/ImportWallet/controller/import_from_seed_controller.dart';
  import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
  import 'package:lnbg_crypto_wallet_app/Widgets/custom_checkbox.dart';
  import 'package:lnbg_crypto_wallet_app/Widgets/custom_discription_feild.dart';
  import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
  import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';
  import 'package:lnbg_crypto_wallet_app/Widgets/custom_textfeild.dart';
import 'package:shimmer/shimmer.dart';

  class ImportFromSeedPhraseScreen extends StatelessWidget {
    ImportFromSeedPhraseScreen({super.key});
    final ImportFromSeedController controller =
        Get.put(ImportFromSeedController());

    @override
    Widget build(BuildContext context) {
      var theme = Theme.of(context);
      bool isDarkMode =
          theme.brightness == Brightness.dark; // Check if dark mode is active

      return Scaffold(
        backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
        appBar: PreferredSize(
           preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Obx((){
            return 
            controller.isLoading.value||controller.walletCreatingController.isLoading.value?
            shimmerAppBar():
            AppBar(
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
              "Import From Seed".tr,
              style: GoogleFonts.urbanist(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? whiteColor : blackColor2),
            ),
            // actions: [
            //   Padding(
            //     padding: EdgeInsets.only(right: 20.w),
            //     child: GestureDetector(
            //       onTap: () {
            //         controller.authenticate(context);
            //       },
            //       child: SizedBox(
            //           height: 28.h,
            //           width: 28.w,
            //           child: Center(
            //               child: SvgPicture.asset(
            //             scanIcon,
            //             colorFilter: ColorFilter.mode(
            //                 isDarkMode ? whiteColor : blackColor2, BlendMode.srcIn),
            //           ))),
            //     ),
            //   )
            // ],
                
          );
          }),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Form(
            key: controller.importSeedKey,
            child: Obx((){
              return 
              controller.isLoading.value||controller.walletCreatingController.isLoading.value?
              buildShimmerLoading():
              Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 25.h, left: 18.w, right: 18.w, bottom: 20.h),
                  child: Column(
                    children: [
                      CustomDescriptionTextField(
                        hintText: "Seed Phrase".tr,
                        controller: controller.seedPhraseController,
                        labelText: "Seed Phrase".tr,
                        // suffixIcoPath: eyeIcon,
                        //prefixIconPath: eyeIcon,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Seed phrase cannot be empty".tr;
                          } else {
                            // Split the input into words
                            List<String> words = value.trim().split(' ');

                            // Check if the length is exactly 12 words
                            if (words.length != 12) {
                              return "Phrase must consist of exactly 12 words".tr;
                            }

                            // Optionally, check if all words are valid (if necessary)
                            for (var word in words) {
                              if (word.isEmpty) {
                                return "Seed phrase cannot have empty words".tr;
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
                        hintText: "Password".tr,
                        controller: controller.passController,
                        labelText: "New Password".tr,
                        suffixIcoPath: eyeIcon,
                        prefixIconPath: lockIcon,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password cannot be empty".tr;
                          } else if (value.length < 8) {
                            return "Must be at least 8 characters".tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomTextField(
                        isPasswordField: true,
                        hintText: "Confirm Password".tr,
                        controller: controller.confirmPasswordController,
                        labelText: "Confirm New Password".tr,
                        suffixIcoPath: eyeIcon,
                        prefixIconPath: lockIcon,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm Password cannot be empty".tr;
                          } else if (value != controller.passController.text) {
                            return "Password must be match".tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35.h,
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
                                  text: "I agree to LNBG Wallet ".tr,
                                  style: GoogleFonts.urbanist(
                                      color:
                                          isDarkMode ? whiteColor : blackColor2,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800,
                                      height: 1.4.h),
                                  children: [
                                    TextSpan(
                                      text: "Term & Conditions.".tr,
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
                  color: isDarkMode ? lightBlackColor : greyColor4,
                ),
                SizedBox(
                  height: 200.h,
                )
              ],
            );
            })    ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            child: Obx(() {
              return controller.walletCreatingController.isLoading.value||controller.isLoading.value
                  ? shimmerOrangeButton()
                  : CustomOrangeButton(
                      buttonText: "Import".tr,
                      onPressed: () {
                        controller.isChecked.value
                            ? controller.verfifyMnemonicAndImport()
                            : Get.snackbar(
                                backgroundColor: orange3,
                                snackPosition: SnackPosition.TOP,
                                "Attention".tr,
                                "Please accept terms and conditions".tr);
                      });
            })),
      );
    }
  Widget shimmerAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    shadowColor: Colors.white,
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 0.0,
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 28.h,
          width: 28.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
      ),
    ),
    title: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 24.sp,
        width: 150.w, // Adjust width based on the length of the title
        color: Colors.white,
      ),
    ),
  );
}
Widget shimmerOrangeButton() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 50.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r), // Match your button's radius
      ),
    ),
  );
}
Widget buildShimmerLoading() {
  return SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25.h, left: 18.w, right: 18.w, bottom: 20.h),
          child: Column(
            children: [
              shimmerContainer(height: 55.h, width: double.infinity), // Seed Phrase
              SizedBox(height: 15.h),
              shimmerContainer(height: 55.h, width: double.infinity), // Password
              SizedBox(height: 30.h),
              shimmerContainer(height: 55.h, width: double.infinity), // Confirm Password
              SizedBox(height: 35.h),
              shimmerContainer(height: 1.h, width: double.infinity), // Divider
              SizedBox(height: 20.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  shimmerContainer(height: 24.h, width: 24.w, borderRadius: 5), // Checkbox
                  SizedBox(width: 12.w),
                  Expanded(
                    child: shimmerContainer(height: 18.h, width: double.infinity), // Terms Text
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey[300],
        ),
        SizedBox(height: 200.h),
      ],
    ),
  );
}

Widget shimmerContainer({required double height, required double width, double borderRadius = 10}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
  );
}

  }
