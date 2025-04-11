import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class ShimmerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;

  const ShimmerAppBar({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
      highlightColor: isDarkMode ? Colors.grey[500]! : Colors.grey[100]!,
      child: Padding(
        padding:  EdgeInsets.only(top:40.h,left: 5.w ),
        child: Container(
          height: preferredSize.height,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 28.w,
                height: 28.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                width: 120.w,
                height: 24.h,
                color: Colors.white,
              ),
              const Spacer(),
              Container(
                width: 20.w,
                height: 20.h,
                margin: EdgeInsets.only(right: 20.w),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
