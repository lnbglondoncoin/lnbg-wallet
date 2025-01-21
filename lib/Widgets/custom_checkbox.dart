import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final Function(bool) onChanged;

  const CustomCheckbox({
    Key? key,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          color: isChecked ? orange3 : whiteColor,
        ),
        child: isChecked
            ? Icon(Icons.check, size: 12.h, color: whiteColor)
            : null,
      ),
    );
  }
}
