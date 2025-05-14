import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWithPaste extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  // final String? iconPath;
  final bool isDarkMode;
  final Color lightColor;
  final Color darkColor;
  final Color accentColor;

  const CustomTextFieldWithPaste({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    // this.iconPath,
    required this.isDarkMode,
    required this.lightColor,
    required this.darkColor,
    required this.accentColor,
    
      });

  Future<void> _pasteText() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      controller.text = data.text!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? darkColor : lightColor,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
                controller: controller,
              validator: validator,
              
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                // errorStyle: GoogleFonts.urbanist(
                //   color: Colors.red,
                //   fontSize: 14.sp,
                // ),
                suffixIcon: GestureDetector(
            onTap: _pasteText,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Text(
                "Paste".tr,
                style:  GoogleFonts.urbanist(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  color: accentColor,
                ),
              ),
            ),
          ),
                hintStyle: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 18.sp,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
              ),
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w400,
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 18.sp,
              ),
            ),
          ),
          
          // if (iconPath != null)
          //   Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 10.w),
          //     child: SizedBox(
          //       height: 20.h,
          //       width: 20.w,
          //       child: SvgPicture.asset(
          //         iconPath!,
          //         colorFilter: ColorFilter.mode(
          //           accentColor,
          //           BlendMode.srcIn,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}