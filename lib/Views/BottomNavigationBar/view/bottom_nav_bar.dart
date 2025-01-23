import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/BottomNavigationBar/controller/bottom_nav_bar_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/HomeScreen/view/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> _pages = [
    HomeScreenView(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
  ];

  final List<String> _labels = ["Wallet", "Discover", "Browse", "Settings"];
  final List<String> _icons = [
    "assets/icons/wallet.svg",
    "assets/icons/discover.svg",
    "assets/icons/browse.svg",
    "assets/icons/settings.svg",
  ];
  var controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Obx(() => _pages[controller.currentIndex.value]),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: BottomAppBar(
          height: 64.h,
          padding: EdgeInsets.zero,
          color: whiteColor,
          elevation: 0,
          child: Container(
            height: 64.h,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                _icons.length,
                (index) => buildNavItem(index, _icons[index], _labels[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector buildNavItem(int index, String iconPath, String label) {
    return GestureDetector(
      onTap: () {
        controller.updateIndex(index);
      },
      child: Obx(() {
        final isSelected = controller.currentIndex.value == index;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SvgPicture.asset(
                    isSelected
                        ? iconPath.replaceFirst('.svg', '2.svg')
                        : iconPath,
                    width: 24.w,
                    height: 24.h,
                  ),
            SizedBox(width: 15.w),
            Text(
              label,
              style: GoogleFonts.urbanist(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? orange3 : greyColor2),
            )
          ],
        );
      }),
    );
  }
}
