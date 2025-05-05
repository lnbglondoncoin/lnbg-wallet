import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class ReusableSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool isDarkMode;

  const ReusableSearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: isDarkMode ? whiteColor : blackColor2),
        decoration: InputDecoration(
          hintText: "Search Token...",
          hintStyle: GoogleFonts.urbanist(color: greyColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDarkMode ? lightBlackColor : lightBlack,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDarkMode ? lightBlackColor : lightBlack,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDarkMode ? lightBlackColor : lightBlack,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          prefixIcon: Icon(Icons.search, color: greyColor),
        ),
      ),
    );
  }
}