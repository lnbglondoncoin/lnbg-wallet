import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSuffix;
  final String title;
  final String iconPath;
  const CustomAppBar(
      {super.key,
      required this.title,
      required this.iconPath,
      this.isSuffix = false});

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      shadowColor: theme.scaffoldBackgroundColor,
      foregroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor:theme.scaffoldBackgroundColor,
      elevation: 0.0,
      centerTitle: false,
      leading: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: SizedBox(
              height: 28.h,
              width: 28.w,
              child: Center(child: SvgPicture.asset(arrowLeft,colorFilter: ColorFilter.mode(isDarkMode?whiteColor:blackColor2, BlendMode.srcIn),))),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.urbanist(
            fontSize: 24.sp, fontWeight: FontWeight.w700, color: isDarkMode?whiteColor:blackColor2),
      ),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: isSuffix == true
                ? GestureDetector(
                    onTap: () {
                      // Get.to(()=>FingerPrintScanScreen());
                    },
                    child: SizedBox(
                        height: 28.h,
                        width: 28.w,
                        child: Center(child: SvgPicture.asset(iconPath,colorFilter: ColorFilter.mode(isDarkMode?whiteColor:blackColor2, BlendMode.srcIn),))),
                  )
                : const SizedBox())
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
