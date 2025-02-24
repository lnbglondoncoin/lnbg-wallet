import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class CustomDivider extends StatelessWidget {

  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
      var theme = Theme.of(context);
    var textTheme = theme.textTheme;
     bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active

    return Container(
      height: 2.h,
      color: isDarkMode?lightBlackColor:lightBlack,
    );
  }
}

class CustomDivider2 extends StatelessWidget {

  const CustomDivider2({super.key});

  @override
  Widget build(BuildContext context) {
      var theme = Theme.of(context);
    var textTheme = theme.textTheme;
     bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active

    return Container(
      height: 1.h,
      color: isDarkMode?greyColor:greyColor,
    );
  }
}
