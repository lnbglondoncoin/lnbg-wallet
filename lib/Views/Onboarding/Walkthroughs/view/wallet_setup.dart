import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/ImportWallet/view/import_from_seed_phrase.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/create_new_wallet.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';

class WalletSetUpScreen extends StatelessWidget {
  const WalletSetUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: AppBar(
        backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
        shadowColor: isDarkMode ? lightBlackColor3 : whiteColor,
        foregroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
        surfaceTintColor: isDarkMode ? lightBlackColor3 : whiteColor,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SizedBox(
              height: 28.h,
              width: 28.w,
              child: Center(
                child: SvgPicture.asset(
                  arrowLeft,
                  colorFilter: ColorFilter.mode(
                    isDarkMode ? whiteColor : blackColor2,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 1.sh),
          child: IntrinsicHeight(
            child: Column(
              children: [
                /// Image section
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Image.asset(
                      wallet,
                     // width: 350.w,
                    ),
                  ),
                ),

                /// Text & Buttons section
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Wallet Setup",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w700,
                            color: darkPrimaryColor,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Easily create a new wallet or import your existing one using a seed phrase. Get started with LNBG Coin and securely manage your digital assets today!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? whiteColor : darkGreyColor,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        CustomOrangeButton(
                          buttonText: "Create a New Wallet",
                          onPressed: () {
                            Get.toNamed(AppRoutes.createNewWallet);
                            
                          },
                        ),
                        SizedBox(height: 25.h),
                        CustomLightGreenButton(
                          buttonText: "Import Using Seed Phrase",
                          onPressed: () {
                            Get.toNamed(AppRoutes.importFromSeedPhraseScreen);
                           
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


