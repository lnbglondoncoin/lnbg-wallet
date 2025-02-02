import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [orange1, orange2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(100.r),
        boxShadow: [
          BoxShadow(
            color: lightGreenColor
                .withOpacity(0.25), // Light green shadow with transparency
            blurRadius: 24, // Blur size
            spreadRadius: 0, // No spread
            offset: const Offset(4, 9), // Moves shadow 4px right, 9px down
          ),
        ],
      ),
      height: 59.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Transparent to show gradient
          shadowColor: Colors.transparent, // Removes default shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: GoogleFonts.urbanist(
              color: whiteColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              height: 1.2.h),
        ),
      ),
    );
  }
}

class CustomLightGreenButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomLightGreenButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
        var theme = Theme.of(context);
    var textTheme = theme.textTheme;
     bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode?lightBlackColor: lightGreenColor2,
        borderRadius: BorderRadius.circular(100.r),
      ),
      height: 59.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Transparent to show gradient
          shadowColor: Colors.transparent, // Removes default shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: GoogleFonts.urbanist(
              color: isDarkMode?whiteColor: orange3,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              height: 1.2.h),
        ),
      ),
    );
  }
}
