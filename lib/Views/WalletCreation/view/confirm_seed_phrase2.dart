import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/animation_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/wallet_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_loading_spinner.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_step_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/shimmer_app_bar_widget.dart';
import 'package:shimmer/shimmer.dart';

class ConfirmSeedPhrase2Screen extends StatelessWidget {
  ConfirmSeedPhrase2Screen({super.key});
  final StepController controller = Get.put(StepController());
  final walletCreatingController = Get.find<WalletCreatingController>();
  final ShakeAnimationController shakeController =
      Get.put(ShakeAnimationController());
  final player = AudioPlayer();
  void _playNotificationTone() async {
    await player.play(AssetSource('sounds/errorSund.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: PreferredSize(
         preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx((){
          return 
          walletCreatingController.isLoading.value?ShimmerAppBar(isDarkMode:isDarkMode):
          CustomStepAppBar(
          onBackTap: () {
            walletCreatingController.indexes.clear();
            walletCreatingController.changeisTrue(true);
            walletCreatingController.orderList.clear();
            Get.back();
          },
          currentIndex: controller.currentIndex,
          onWillPop: () {
            walletCreatingController.indexes.clear();
            walletCreatingController.orderList.clear();
            Get.back();
          }, // Pass the RxInt
        );
        }),
      ),
          body: 
      Obx((){
          return 
        walletCreatingController.isLoading.value?shimmerSeedPhraseScreen():
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomDivider(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Confirm Seed Phrase".tr,
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w700,
                          fontSize: 32.sp,
                          color: orange3),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Select each word in the order it was presented to you.".tr,
                    style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? whiteColor : darkGreyColor,
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  const CustomDivider(),
                  SizedBox(
                    height: 45.h,
                  ),
                  Center(
                    child: Text(
                      "12",
                      style: GoogleFonts.urbanist(
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w700,
                          color: orange3),
                    ),
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  Obx(() {
                    if (!walletCreatingController.isTrue.value) {
                      shakeController.startShakeAnimation();
                      _playNotificationTone();
                    }

                    return GetBuilder<ShakeAnimationController>(
                      builder: (controller) {
                        return AnimatedBuilder(
                          animation: controller.rotationAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: controller.rotationAnimation.value,
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  transform: walletCreatingController
                                          .isTrue.value
                                      ? Matrix4.identity()
                                      : Matrix4.rotationZ(
                                          0.1), // Rotate 30 degrees (0.1 radians)
                                  onEnd: () {
                                    walletCreatingController.changeisTrue(true);
                                  },
                                  curve: Curves.easeInOut,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient:
                                          walletCreatingController.isTrue.value
                                              ? const LinearGradient(
                                                  colors: [
                                                    Color(0xFFFACC15),
                                                    Color(0xFFFFE580)
                                                  ],
                                                )
                                              : const LinearGradient(
                                                  colors: [redColor, redColor],
                                                ),
                                      borderRadius: BorderRadius.circular(40.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(2.h),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40.r),
                                          color: isDarkMode
                                              ? lightBlackColor3
                                              : whiteColor,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(20.h),
                                          child: GridView.builder(
                                            shrinkWrap:
                                                true, // Ensures the GridView takes only the space it needs
                                            physics:
                                                const NeverScrollableScrollPhysics(), // Prevents scrolling in GridView
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3, // 2 columns
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio:
                                                  3, // Width to height ratio
                                            ),
                                            itemCount: walletCreatingController
                                                .shuffledList.length,
                                            itemBuilder: (context, index) {
                                              var suffeledItem =
                                                  walletCreatingController
                                                      .shuffledList[index];
                                              return Obx(() {
                                                return GestureDetector(
                                                  onTap: () {
                                                    walletCreatingController
                                                        .addInOrderList(
                                                            suffeledItem);
                                                    walletCreatingController
                                                        .addIndexesToList(
                                                            index);
                                                  },
                                                  child: Container(
                                                    height: 45.h,
                                                    decoration: BoxDecoration(
                                                      color: walletCreatingController
                                                              .indexes
                                                              .contains(index)
                                                          ? orange3
                                                          : isDarkMode
                                                              ? lightBlackColor
                                                              : greyColor4,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        suffeledItem,
                                                        style: GoogleFonts
                                                            .urbanist(
                                                          fontSize: 18.sp,
                                                          color: walletCreatingController
                                                                  .indexes
                                                                  .contains(
                                                                      index)
                                                              ? whiteColor
                                                              : isDarkMode
                                                                  ? whiteColor
                                                                  : darkGreyColor,
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                  )),
                            );
                          },
                        );
                      },
                    );
                  }),
                  SizedBox(
                    height: 70.h,
                  ),
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
                                    gradient: const LinearGradient(colors: [
                                      lightPrimaryColor,
                                      primaryColor,
                                    ])),
                              ));
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            const CustomDivider(),
            SizedBox(
              height: 200.h,
            )
          ],
        ),
      );
      }),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding:
              EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w, bottom: 10.h),
          child: Obx((){
            return walletCreatingController.isLoading.value?
            shimmerLoadingWidget():
            CustomOrangeButton(
              buttonText: "Next".tr,
              onPressed: () {
                walletCreatingController.changeisTrue(true);
                if (listEquals(walletCreatingController.secondHalfofMnemonic,
                    walletCreatingController.orderList)) {
                  walletCreatingController.savePhraseToPrefs(
                      walletCreatingController.mnemonic.value);

                  _showPopup(context);
                } else {
                  walletCreatingController.changeisTrue(false);
                  Get.snackbar('Error'.tr,
                      'Please tap phrases in the order provided to you on the previous page'.tr,
                      backgroundColor: orange3,
                      snackPosition: SnackPosition.TOP);
                }
              });
          })
          ),
    );
  }

Widget shimmerLoadingWidget() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}

Widget shimmerSeedPhraseScreen() {
  return SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomDivider(),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 200.w, // Adjust the width according to your need
                    height: 32.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 250.w, // Adjust the width
                  height: 18.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              const CustomDivider(),
              SizedBox(
                height: 45.h,
              ),
              Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 100.w,
                    height: 48.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 45.h,
              ),
              Obx(() {
                return GetBuilder<ShakeAnimationController>(
                  builder: (controller) {
                    return AnimatedBuilder(
                      animation: controller.rotationAnimation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: controller.rotationAnimation.value,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            transform: walletCreatingController.isTrue.value
                                ? Matrix4.identity()
                                : Matrix4.rotationZ(0.1),
                            onEnd: () {
                             // walletCreatingController.changeisTrue(true);
                            },
                            curve: Curves.easeInOut,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: double.infinity,
                                height: 300.h, // Adjust height as necessary
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.grey[300]!, Colors.grey[100]!],
                                  ),
                                  borderRadius: BorderRadius.circular(40.r),
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
              SizedBox(
                height: 70.h,
              ),
              SizedBox(
                height: 3.h,
                child: ListView.builder(
                  itemCount: 12,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 3.w),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 3.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.r),
                            gradient: LinearGradient(
                              colors: [Colors.grey[300]!, Colors.grey[100]!],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        const CustomDivider(),
        SizedBox(
          height: 200.h,
        ),
      ],
    ),
  );
}

  void _showPopup(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
          backgroundColor: isDarkMode ? lightBlackColor2 : whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon: isDarkMode
              ? Image.asset(
                  "assets/images/success3.png",
                  height: 180.h,
                  width: 186.w,
                )
              : Image.asset(
                  "assets/images/success.png",
                  height: 180.h,
                  width: 186.w,
                ),
          title: Text(
            "Successful!".tr,
            style: GoogleFonts.urbanist(
                fontSize: 24.sp, fontWeight: FontWeight.w700, color: orange3),
          ),
          content: Text(
              "You\'ve successfully protected your wallet. Remember to keep your seed phrase safe, it\'s your responsibility!".tr,
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? whiteColor : blackColor2)),
          actions: [
            Obx(() {
              return GestureDetector(
                onTap: () async {
                  Get.log("response is hfmh");

                  final privateKey = await walletCreatingController
                      .getPrivateKey(walletCreatingController.seedPhrase!);
                  Get.log(privateKey);
                  if (privateKey.isNotEmpty) {
                    walletCreatingController.isAcccontCreated.value=true;
                    await walletCreatingController.setPrivateKey(privateKey);
                    await walletCreatingController.loadWaletData(true);
                   // walletCreatingController.isNewAccountCraeting.value=true;
                   // await walletCreatingController.fetchCoinData(true);
                  } else {
                    Get.snackbar(
                        "Error".tr, "Failed to create wallet. Try again.".tr);
                  }
                  //  walletCreatingController.fetchCoinData();
                },
                child: walletCreatingController.isLoading.value
                    ? const Center(
                        child: LoadingSpinner()
                      )
                    : Container(
                        height: 58.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            gradient: const LinearGradient(
                                colors: [orange2, orange1])),
                        child: Center(
                          child: Text(
                            "OK".tr,
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp,
                                color: whiteColor),
                          ),
                        ),
                      ),
              );
            }),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                "Your seeed phrase in Settings > Security & Privacy".tr,
                style: GoogleFonts.urbanist(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? whiteColor : blackColor2),
              ),
            )
          ],
        );
      },
    );
  }
}
