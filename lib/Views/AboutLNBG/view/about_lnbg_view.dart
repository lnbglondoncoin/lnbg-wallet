import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/AboutLNBG/controller/about_lnbg_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class AboutLNBG extends StatelessWidget {
  AboutLNBG({super.key});
  final controller = Get.put(AboutLNBGController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: const CustomAppBar(title: "About LNBG Wallet", iconPath: ""),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                logo,
                height: 187.h,
                width: 108.w,
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  print(Get.currentRoute);
                },
                child: Text(
                  "LNBG Wallet v1.4.0",
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: isDarkMode ? whiteColor : blackColor2),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const CustomDivider(),
            SizedBox(
              height: 30.h,
            ),
            ListView.builder(
                itemCount: controller.aboutTabs.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: GestureDetector(
                      onTap: (){
                        controller.aboutLnbgTabsOnTap(index);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.aboutTabs[index],
                            style: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color: isDarkMode ? whiteColor : blackColor2),
                          ),
                          SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/arrowRight.svg",
                                colorFilter: ColorFilter.mode(
                                    isDarkMode ? whiteColor : blackColor2,
                                    BlendMode.srcIn),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
