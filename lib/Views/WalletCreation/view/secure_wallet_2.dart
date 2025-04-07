import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/wallet_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/hidden_write_phrase.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_step_app_bar.dart';

class SecureWallet2 extends StatelessWidget {
  SecureWallet2({super.key});
  final StepController controller = Get.put(StepController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: CustomStepAppBar(
        onBackTap: () {
          Get.back();
        },
        currentIndex: controller.currentIndex,
        onWillPop: () {
          Get.back();
        }, // Pass the RxInt
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomDivider(),
                  SizedBox(
                    height: 25.h,
                  ),
                  Center(
                    child: Text(
                      "Secure Your Wallet",
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w700,
                          fontSize: 32.sp,
                          color: orange3),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Secure your wallet's ",
                        style: GoogleFonts.urbanist(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? whiteColor : darkGreyColor,
                        ),
                        children: [
                          TextSpan(
                            text: '"', // Opening black quote
                            style: GoogleFonts.urbanist(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? whiteColor : darkGreyColor,
                            ),
                          ),
                          TextSpan(
                            text: "Seed Phrase",
                            style: GoogleFonts.urbanist(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: orange3,
                            ),
                          ),
                          TextSpan(
                            text: '"', // Closing black quote
                            style: GoogleFonts.urbanist(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? whiteColor : darkGreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  const CustomDivider(),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    "Manual",
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                        color: isDarkMode ? whiteColor : blackColor2),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Write down your seed phrase on a piece of paper and store in a safe place.",
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w500,
                        fontSize: 19.sp,
                        color: isDarkMode ? whiteColor : darkGreyColor),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Security level: Very strong",
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: isDarkMode ? whiteColor : darkGreyColor),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 4.h,
                    child: ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: Container(
                              height: 4.h,
                              width: 63.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.r),
                                gradient: const LinearGradient(
                                  colors: [
                                    orange2,
                                    orange1
                                  ], // Your gradient colors
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Risks are: ",
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: isDarkMode ? whiteColor : darkGreyColor),
                  ),
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "• ", // Bullet point
                              style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: isDarkMode ? whiteColor : darkGreyColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                index == 0
                                    ? "You lose it"
                                    : index == 1
                                        ? "You forget where you put it"
                                        : "Someone else finds it",
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                  color:
                                      isDarkMode ? whiteColor : darkGreyColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Other options: Doesn't have to be paper!",
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: isDarkMode ? whiteColor : darkGreyColor),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Tips:",
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: isDarkMode ? whiteColor : darkGreyColor),
                  ),
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "• ", // Bullet point
                              style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: isDarkMode ? whiteColor : darkGreyColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                index == 0
                                    ? "Store in bank vault"
                                    : index == 1
                                        ? "Store in a safe"
                                        : "Store in multiple secret places",
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                  color:
                                      isDarkMode ? whiteColor : darkGreyColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 200.h,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? lightBlackColor3 : whiteColor,
            border: Border(
                top: BorderSide(
                    color: isDarkMode ? lightBlackColor : greyColor4))),
        child: Padding(
            padding: EdgeInsets.only(
                left: 15.w, top: 20.h, right: 15.w, bottom: 10.h),
            child: CustomOrangeButton(
                buttonText: "Start",
                onPressed: () {
                  Get.to(() => HiddenWriteSeedPhraseScreen());
                })),
      ),
    );
  }
}
