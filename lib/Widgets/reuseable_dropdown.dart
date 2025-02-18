import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableDropdown extends StatelessWidget {
  final List<String> items;
  final RxString selectedValue;

  ReusableDropdown({required this.items, required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue.value,
            icon: SvgPicture.asset(
              'assets/icons/dropdown_icon.svg',
              height: 20.h,
              width: 20.w,
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: GoogleFonts.urbanist(fontSize: 16.sp),
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
