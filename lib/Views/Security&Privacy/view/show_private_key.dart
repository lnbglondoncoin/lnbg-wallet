import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class ShowPrivateKeyScreen extends StatelessWidget {
  ShowPrivateKeyScreen({super.key});

  final walletCreatingController = Get.find<WalletCreatingController>();

  @override
  Widget build(BuildContext context) {
    walletCreatingController.getSeedPhrase();
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: Get.height/8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        print(walletCreatingController.password);
                      },
                      child: Text(
                        textAlign: TextAlign.center,
                        "Your private key".tr,
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            fontSize: 32.sp,
                            color: orange3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "This is the private key for the current selected wallet account: AndrewAinsley. Never disclose this key. Anyone with your private key can fully control your account, including transferring away any of your funds.".tr,
                    style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? whiteColor : darkGreyColor,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  const CustomDivider(),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                  //  height: 378.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            isDarkMode
                                ? const Color(0XffFB9400)
                                : const Color(0xFFFACC15),
                            isDarkMode
                                ? const Color(0xffFFAB38)
                                : const Color(0xFFFFE580)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.r),
                            color: isDarkMode ? lightBlackColor3 : whiteColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),
                            child: SelectableText(
                              textAlign: TextAlign.center,
                      walletCreatingController.privateKey!,
                      style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          color: isDarkMode ? whiteColor : darkGreyColor,
                          fontWeight: FontWeight.w700),
                    ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ),
            ),
            const CustomDivider(),
          ],
        ),
      ),
    );
  }
}
