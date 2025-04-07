import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class ClearHistoryBottomSheet extends StatefulWidget {
  const ClearHistoryBottomSheet({super.key});

  @override
  ClearHistoryBottomSheetState createState() => ClearHistoryBottomSheetState();
}

class ClearHistoryBottomSheetState extends State<ClearHistoryBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start position (bottom of screen)
      end: const Offset(0, 0), // End position (fully visible)
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.reverse(); // Animate closing before disposal
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 25.w),
        decoration: BoxDecoration(
          color: isDarkMode ? lightBlackColor2 : whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(49.r), topRight: Radius.circular(49.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: isDarkMode ? lightBlackColor : greyColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "Clear Browsing Data?",
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    color: isDarkMode ? whiteColor : blackColor2),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const CustomDivider(),
            SizedBox(
              height: 25.h,
            ),
            Row(
              children: [
                Flexible(
                    child: CustomLightGreenButton(
                        buttonText: "Cancel", onPressed: () {})),
                SizedBox(
                  width: 15.w,
                ),
                Flexible(
                    child: CustomButton(
                        buttonText: "Yes, Clear", onPressed: () {}))
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
          ],
        ),
      ),
    );
  }
}
