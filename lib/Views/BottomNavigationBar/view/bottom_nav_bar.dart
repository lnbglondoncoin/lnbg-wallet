import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/BottomNavigationBar/controller/bottom_nav_bar_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/view/browse.dart';
import 'package:lnbg_crypto_wallet_app/Views/Discover/view/discover.dart';
import 'package:lnbg_crypto_wallet_app/Views/HomeScreen/view/home_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Settings/view/settings_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> _pages = [
    const HomeScreenView(),
    const DiscoverView(),
    const BrowseScreen(),
    SettingView(),
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
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      body: Obx(() => _pages[controller.currentIndex.value]),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: BottomAppBar(
          height: 64.h,
          padding: EdgeInsets.zero,
          color: isDarkMode ? lightBlackColor3 : whiteColor,
          elevation: 0,
          child: Container(
            height: 64.h,
            decoration: BoxDecoration(
              color: isDarkMode ? lightBlackColor3 : whiteColor,
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
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return GestureDetector(
      onTap: () {
        controller.updateIndex(index);
      },
      child: Obx(() {
        final isSelected = controller.currentIndex.value == index;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 21.w,
              height: 21.h,
              child: Center(
                child: SvgPicture.asset(
                  isSelected
                      ? iconPath.replaceFirst(
                          '.svg', isDarkMode ? '4.svg' : '2.svg')
                      : iconPath,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              label,
              style: GoogleFonts.urbanist(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? isDarkMode
                          ? lightGreenColor
                          : orange3
                      : greyColor2),
            )
          ],
        );
      }),
    );
  }
}
