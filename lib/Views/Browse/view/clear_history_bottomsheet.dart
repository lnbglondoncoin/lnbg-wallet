import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/controller/browse_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:shimmer/shimmer.dart';

class ClearHistoryBottomSheet extends StatefulWidget {
  const ClearHistoryBottomSheet({super.key});

  @override
  ClearHistoryBottomSheetState createState() => ClearHistoryBottomSheetState();
}

class ClearHistoryBottomSheetState extends State<ClearHistoryBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
 final controller = Get.put(BrowseController());
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
      child:Obx((){
        return  controller.isLoading.value?shimmerLoaderSheet(context):
        Container(
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
                "Clear Browsing Data?".tr,
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
                        buttonText: "Cancel".tr, onPressed: () {
                          Navigator.pop(context);
                        })),
                SizedBox(
                  width: 15.w,
                ),
                Flexible(
                    child: CustomButton(
                        buttonText: "Yes, Clear".tr, onPressed: ()async {
                       await   controller.clearHistory();
                        }))
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
          ],
        ),
      );
      })  );
  }

  
Widget shimmerLoaderSheet(BuildContext context) {
  var theme = Theme.of(context);
  bool isDarkMode = theme.brightness == Brightness.dark;

  return Container(
    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 25.w),
    decoration: BoxDecoration(
      color: isDarkMode ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(49.r),
        topRight: Radius.circular(49.r),
      ),
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
              color: isDarkMode ? Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Center(
          child: Shimmer.fromColors(
            baseColor: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.2),
            highlightColor: isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.4),
            child: Container(
              width: 200.w,
              height: 24.h,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        const Divider(),
        SizedBox(
          height: 25.h,
        ),
        Row(
          children: [
            Flexible(
              child: Shimmer.fromColors(
                baseColor: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.2),
                highlightColor: isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.4),
                child: Container(
                  height: 45.h,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Flexible(
              child: Shimmer.fromColors(
                baseColor: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.2),
                highlightColor: isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.4),
                child: Container(
                  height: 45.h,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
      ],
    ),
  );
}
}
