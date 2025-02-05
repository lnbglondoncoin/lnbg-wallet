import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final Function(bool) onChanged;

  const CustomCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
       var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active

    return GestureDetector(
      onTap: () {
        onChanged(!isChecked);
      },
      child: Container(
        width: 20.w,
        height: 20.h,
        decoration: BoxDecoration(
          border: Border.all(color: orange3, width: 2),
          borderRadius: BorderRadius.circular(5),
          color: isChecked ? orange3 :theme.scaffoldBackgroundColor,
        ),
        child:
            isChecked ? Icon(Icons.check, size: 12.h, color: whiteColor) : null,
      ),
    );
  }
}
