

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/animation_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/wallet_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/confirm_seed_phrase2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_step_app_bar.dart';

class ConfirmSeedPhraseScreen extends StatelessWidget {
  ConfirmSeedPhraseScreen({super.key});
  final StepController controller = Get.put(StepController());
  final walletCreatingController = Get.find<WalletCreatingController>();
   final ShakeAnimationController shakeController = Get.put(ShakeAnimationController());
   final player = AudioPlayer();
   void _playNotificationTone() async {
await player.play(AssetSource('sounds/errorSund.mp3'));

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomStepAppBar(
        onBackTap: () {
          controller.decreseIndexValue(2);
          walletCreatingController.indexes.clear();
          walletCreatingController.shuffledList.clear();
          walletCreatingController.changeisTrue(true);
          walletCreatingController.orderList.clear();
          Get.back();
        },
        currentIndex: controller.currentIndex, onWillPop: () {
          controller.decreseIndexValue(2);
          walletCreatingController.indexes.clear();
          walletCreatingController.shuffledList.clear();
          walletCreatingController.changeisTrue(true);
          walletCreatingController.orderList.clear();
          Get.back();
        }, // Pass the RxInt
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDivider(),
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Confirm Seed Phrase",
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w700,
                          fontSize: 32.sp,
                          color: orange3),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    textAlign: TextAlign.center,
                    "Select each word in the order it was presented to you.",
                    style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: darkGreyColor,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  CustomDivider(),
                  SizedBox(height: 45.h),
                  Center(
                    child: Text(
                      "${walletCreatingController.shuffleFirstPart.length.toString()}.",
                      style: GoogleFonts.urbanist(
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w700,
                          color: orange3),
                    ),
                  ),
                  SizedBox(height: 45.h),
             Obx(() {
  if (!walletCreatingController.isTrue.value) {
    shakeController.startShakeAnimation();
    _playNotificationTone();
  }

  return 
GetBuilder<ShakeAnimationController>(
              builder: (controller) {
                return AnimatedBuilder(
                  animation: controller.rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: controller.rotationAnimation.value,
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          transform: walletCreatingController.isTrue.value
                              ? Matrix4.identity()
                              : Matrix4.rotationZ(0.1), // Rotate 30 degrees (0.1 radians)
                          onEnd: () {
                            // Reset rotation after animation completes
                            walletCreatingController.changeisTrue(true);
                          },
                          curve: Curves.easeInOut,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: walletCreatingController.isTrue.value
                                  ? LinearGradient(
                                      colors: [Color(0xFFFACC15), Color(0xFFFFE580)],
                                    )
                                  : LinearGradient(
                                      colors: [redColor, redColor],
                                    ),
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.r),
                                  color: whiteColor,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20.h),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 3,
                                    ),
                                    itemCount: walletCreatingController.shuffleFirstPart.length,
                                    itemBuilder: (context, index) {
                                      var suffeledItem = walletCreatingController.shuffleFirstPart[index];
                                      return Obx(() {
                                        return GestureDetector(
                                          onTap: () {
                                            walletCreatingController.addInOrderList(suffeledItem);
                                            walletCreatingController.addIndexesToList(index);
                                          },
                                          child: Container(
                                            height: 45.h,
                                            decoration: BoxDecoration(
                      color: walletCreatingController.indexes.contains(index)
                          ? orange3
                          : greyColor4,
                      borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Center(
                      child: Text(
                        suffeledItem,
                        style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          color: walletCreatingController.indexes.contains(index)
                              ? whiteColor
                              : darkGreyColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    );
                  },
                );
              },
            );
}),
 
 
  SizedBox(height: 70.h),
                  SizedBox(
                    height: 3.h,
                    child: ListView.builder(
                      itemCount: 12,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 3.w),
                          child: Container(
                            height: 3.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.r),
                              gradient: index < 6
                                  ? LinearGradient(
                                      colors: [
                                        lightPrimaryColor,
                                        primaryColor,
                                      ],
                                    )
                                  : LinearGradient(
                                      colors: [
                                        lightBlack,
                                        lightBlack,
                                      ],
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            CustomDivider(),
            SizedBox(height: 200.h),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            left: 20.w, top: 20.h, right: 20.w, bottom: 10.h),
        child: CustomButton(
            buttonText: "Next",
            onPressed: () {
              if (listEquals(
                  walletCreatingController.firstHalfOfMnemonic,
                  walletCreatingController.orderList)) {
                
                walletCreatingController.changeisTrue(true);
                walletCreatingController.shuffleList(
                    walletCreatingController.mnemonicWords.sublist(6, 12));
                walletCreatingController.orderList.clear();
                Get.to(() => ConfirmSeedPhrase2Screen());
                walletCreatingController.indexes.clear();
                controller.updateIndex(2);
              } else {
                Get.snackbar('Error', 'Please tap phrases in the order provided to you on the previous page',
                backgroundColor: orange3,
                snackPosition: SnackPosition.TOP);
                walletCreatingController.changeisTrue(false);
              }
              print(
                  "first mnemonic is :${walletCreatingController.firstHalfOfMnemonic}");
              print("order list is :${walletCreatingController.orderList}");
            }),
      ),
    );
  }
}


