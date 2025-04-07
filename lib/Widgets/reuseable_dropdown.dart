import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class ReusableDropdown extends StatelessWidget {
  final List<String> items;
  final RxString selectedValue;

  const ReusableDropdown(
      {super.key, required this.items, required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: isDarkMode ? lightBlackColor2 : lightWhiteColor,
          border: Border.all(
              color: isDarkMode ? lightBlackColor2 : lightWhiteColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            dropdownColor: isDarkMode ? lightBlackColor2 : whiteColor,
            value: selectedValue.value,
            icon: SizedBox(
              height: 10.h,
              width: 10.w,
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/diamond.svg',
                  height: 20.h,
                  width: 20.w,
                  colorFilter: ColorFilter.mode(
                      isDarkMode ? whiteColor : blackColor2, BlendMode.srcIn),
                ),
              ),
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: isDarkMode ? whiteColor : blackColor2),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                selectedValue.value = value;
              }
            },
            isExpanded: true,
          ),
        ),
      ),
    );
  }
}
