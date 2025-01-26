import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String iconPath;
  const CustomAppBar({super.key, required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: whiteColor,
          shadowColor: whiteColor,
          foregroundColor: whiteColor,
          surfaceTintColor: whiteColor,
          elevation: 0.0,
          centerTitle: false,
          leading: Padding(
            padding:  EdgeInsets.only(left: 10.w),
            child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: SizedBox(
                height: 28.h,
                width: 28.w,
                child: Center(child: SvgPicture.asset(arrowLeft))),
            ),
          ),
            title: Text(title,style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: blackColor2
            ),),
            actions: [
              Padding(
                padding:  EdgeInsets.only(right: 20.w),
                child: GestureDetector(
                  onTap: (){
                    // Get.to(()=>FingerPrintScanScreen());
                  },
                  child: SizedBox(
                    height: 28.h,
                              width: 28.w,
                    child: Center(child: SvgPicture.asset(iconPath))),
                ),
              )
            ],
        );
  }
    @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}