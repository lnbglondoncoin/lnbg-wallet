import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

// Custom Switch Widget
class CustomSwitch extends StatelessWidget {
  final RxBool isSwitched;
  final VoidCallback? onChanged; // Optional callback

  const CustomSwitch({
    super.key,
    required this.isSwitched,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDarkMode = theme.brightness == Brightness.dark;

    return Obx(
      () => GestureDetector(
        onTap: () {
          isSwitched.value = !isSwitched.value;
          if (onChanged != null) {
            onChanged!();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 44.w,
          height: 24.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: isSwitched.value
                ? isDarkMode
                    ? lightGreenColor
                    : orange1
                : isDarkMode
                    ? lightBlackColor
                    : lightBlack,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Align(
              alignment: isSwitched.value
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: 24.w,
                height: 24.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomOrangeSwitch extends StatelessWidget {
  final RxBool isSwitched;
  final VoidCallback? onChanged; // Optional callback

  const CustomOrangeSwitch({
    super.key,
    required this.isSwitched,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          isSwitched.value = !isSwitched.value;
          if (onChanged != null) {
            onChanged!();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 44.w,
          height: 24.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: isSwitched.value ? orange1 : lightBlackColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Align(
              alignment: isSwitched.value
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: 24.w,
                height: 24.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
