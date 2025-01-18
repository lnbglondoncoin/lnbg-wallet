
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Walkthroughs/controller/walkthrough_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Walkthroughs/view/wallet_setup.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';

// WalkThroughScreen
class WalkThroughScreen extends StatelessWidget {
  WalkThroughScreen({super.key});
  final WalkThroughController controller = Get.put(WalkThroughController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightWhiteColor,
      body: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.walkthroughData.length,
        physics: NeverScrollableScrollPhysics(), // Disable swipe navigation
        itemBuilder: (context, index) {
          final data = controller.walkthroughData[index];
          return WalkThroughPage(
            image: data["image"]!,
            title: data["title"]!,
            description: data["description"]!,
            onNext: controller.nextPage,
            isLastPage: index == controller.walkthroughData.length - 1,
            currentIndex: controller.currentIndex,
          );
        },
      ),
    );
  }
}

// WalkThroughPage
class WalkThroughPage extends StatelessWidget {
  final RxInt currentIndex;
  final String image, title, description;
  final VoidCallback onNext;
  final bool isLastPage;

  const WalkThroughPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.onNext,
    required this.isLastPage,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
          child: Image.asset(image, width: double.infinity),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80.r),
                topRight: Radius.circular(80.r),
              ),
            ),
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w700,
                          color: darkPrimaryColor,
                          height: 1.2.h,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: darkGreyColor,
                          height: 1.3.h,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Container(
                          width: currentIndex.value == index ? 32.w : 8.w,
                          height: 8.h,
                          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.w),
                          decoration: BoxDecoration(
                            borderRadius: currentIndex.value == index
                                ? BorderRadius.circular(100.r)
                                : null,
                            shape: currentIndex.value == index ? BoxShape.rectangle : BoxShape.circle,
                            gradient: LinearGradient(
                              colors: currentIndex.value == index
                                  ? [lightPrimaryColor, primaryColor]
                                  : [greyColor, greyColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  CustomButton(
                    buttonText: isLastPage ? 'Get Started' : 'Next',
                    onPressed:  onNext
                    
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}