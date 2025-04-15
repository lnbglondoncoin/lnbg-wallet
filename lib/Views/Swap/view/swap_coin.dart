import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/controller/swap_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_loading_spinner.dart';
import 'package:shimmer/shimmer.dart';

class SwapCoinScreen extends StatelessWidget {
  SwapCoinScreen({super.key});
  final controller = Get.put(SwapController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: const CustomAppBar(
        title: "Swap",
        iconPath: 'assets/icons/search.svg',
      ),
      body: Obx((){
        return 
        controller.isLoading.value?_buildShimmerLayout(isDarkMode):
        SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SizedBox(
                    height: 48.h,
                    width: 48.w,
                    child: Image.network(
                      controller.firstToken.value.logoUrl,
                      height: 48.h,
                      width: 48.w,
                    ),
                  ),
                  title: Text(
                    "${controller.cryptoAmount.value} ${controller.firstToken.value.symbol}",
                    style: GoogleFonts.urbanist(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? whiteColor : blackColor2),
                  ),
                  subtitle: Text(
                    "TRC20",
                    style: GoogleFonts.urbanist(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode ? greyColor : blackColor2),
                  ),
                );
              }),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 24.h,
                width: 48.w,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/arrowDown.svg",
                    colorFilter: ColorFilter.mode(
                        isDarkMode ? whiteColor : blackColor2, BlendMode.srcIn),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SizedBox(
                  height: 48.h,
                  width: 48.w,
                  child: Image.network(
                    controller.secondToken.value.logoUrl,
                    height: 48.h,
                    width: 48.w,
                  ),
                ),
                title: Text(
                  "${controller.cryptoAmount2nd.value} ${controller.secondToken.value.symbol}",
                  style: GoogleFonts.urbanist(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? whiteColor : blackColor2),
                ),
                subtitle: Text(
                  "TRC20",
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode ? greyColor : blackColor2),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                height: 224.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: isDarkMode ? lightBlackColor2 : whiteColor,
                    border: Border.all(
                        color: isDarkMode ? lightBlackColor : lightBlack),
                    borderRadius: BorderRadius.circular(24.r)),
                child: Padding(
                  padding: EdgeInsets.all(15.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "From",
                            style: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color: isDarkMode ? greyColor : darkGreyColor),
                          ),
                          Text(
                            "Wallet (${controller.walletCreatingCotroller.wallwtAddress.value.substring(0, 6)}...${controller.walletCreatingCotroller.wallwtAddress.value.substring(controller.walletCreatingCotroller.wallwtAddress.value.length - 6)})",
                            style: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode ? whiteColor : blackColor2),
                          ),
                        ],
                      ),
                      //SizedBox(height: 25.h,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: isDarkMode ? lightBlackColor : lightBlack,
                      ),
                      // Sized Box(height: 25.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Provider",
                                style: GoogleFonts.urbanist(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800,
                                    color:
                                        isDarkMode ? greyColor : darkGreyColor),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                  height: 16.h,
                                  width: 16.w,
                                  child: Center(
                                      child: SvgPicture.asset(
                                          "assets/icons/eyeButton.svg")))
                            ],
                          ),
                          Obx(
                            () => Text(
                              controller.formattedProvider,
                              style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: isDarkMode ? whiteColor : blackColor2),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Max Slippage",
                                style: GoogleFonts.urbanist(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800,
                                    color:
                                        isDarkMode ? greyColor : darkGreyColor),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                  height: 16.h,
                                  width: 16.w,
                                  child: Center(
                                      child: SvgPicture.asset(
                                          "assets/icons/eyeButton.svg")))
                            ],
                          ),
                          const Spacer(),
                          Obx(
                            () => Text(
                              controller.formattedSlippage,
                              style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: isDarkMode ? whiteColor : blackColor2),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          GestureDetector(
                              onTap: () => _showSlippageDialog(context),
                              child: SizedBox(
                                  height: 16.h,
                                  width: 16.w,
                                  child: Center(
                                      child: SvgPicture.asset(
                                    "assets/icons/Edit.svg",
                                    colorFilter: ColorFilter.mode(
                                        isDarkMode ? lightGreenColor : orange3,
                                        BlendMode.srcIn),
                                  )))),
                        ],
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Network Fee",
                                style: GoogleFonts.urbanist(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800,
                                    color:
                                        isDarkMode ? greyColor : darkGreyColor),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                  height: 16.h,
                                  width: 16.w,
                                  child: Center(
                                      child: SvgPicture.asset(
                                          "assets/icons/eyeButton.svg")))
                            ],
                          ),
                          const Spacer(),
                          Obx(
                            () => Text(
                              controller.formattedNetworkFee,
                              style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: isDarkMode ? whiteColor : blackColor2),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          SizedBox(
                              height: 16.h,
                              width: 16.w,
                              child: Center(
                                  child: SvgPicture.asset(
                                "assets/icons/Edit.svg",
                                colorFilter: ColorFilter.mode(
                                    isDarkMode ? lightGreenColor : orange3,
                                    BlendMode.srcIn),
                              ))),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
      }) ,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: isDarkMode ? lightBlackColor : greyColor4))),
        child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Obx(() {
              return controller.isLoading.value
                  ? const LoadingSpinner()
                  : isDarkMode
                      ? CustomGreenButton(
                          buttonText: "Confirm",
                          onPressed: () async {
                            await controller.executeSwap();
                            // _showSuccesPopup(context);
                          })
                      : CustomButton(
                          buttonText: "Confirm",
                          onPressed: () async {
                            // _showSuccesPopup(context);
                            await controller.executeSwap();
                          });
            })),
      ),
    );
  }

  void _showSuccesPopup(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
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
          icon: Image.asset(
            isDarkMode
                ? "assets/images/swap_success2.png"
                : "assets/images/swap_success.png",
            height: 180.h,
            width: 186.w,
          ),
          title: Text(
            "Successful Swap!",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? lightGreenColor : orange3),
          ),
          content: Text(
              textAlign: TextAlign.center,
              "Your crypto was swap successfully. You can view more details below.",
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? whiteColor : blackColor2)),
          actions: [
            isDarkMode
                ? CustomGreenButton(
                    buttonText: "View Details",
                    onPressed: () {
                      Navigator.pop(context);
                    })
                : GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 58.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          gradient:
                              const LinearGradient(colors: [orange2, orange1])),
                      child: Center(
                        child: Text(
                          "View Details",
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                              color: whiteColor),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 15.h,
            ),
            CustomLightGreenButton(
                buttonText: "Cancel",
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  void _showSlippageDialog(BuildContext context) {
    // Implementation of _showSlippageDialog method
  }


   Widget _buildShimmerLayout(bool isDarkMode) {
    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Token Container
              Container(
                height: 70.h,
                margin: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  children: [
                    Container(
                      height: 48.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Container(
                          height: 24.h,
                          width: 120.w,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          height: 16.h,
                          width: 60.w,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                 ),

              // Arrow Down
              Center(
                child: Container(
                  height: 24.h,
                  width: 24.w,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                ),
              ),

              // Second Token Container
              Container(
                height: 70.h,
                margin: EdgeInsets.only(bottom: 30.h),
                child: Row(
                  children: [
                    Container(
                      height: 48.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                       borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 24.h,
                          width: 120.w,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          height: 16.h,
                          width: 60.w,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Details Container
     // ... rest of the code remains same ...

// Update only the details container part in _buildShimmerLayout
Container(
  height: 224.h,
  width: double.infinity,
  decoration: BoxDecoration(
    color: Colors.transparent,
    border: Border.all(color: isDarkMode ? lightBlackColor : lightBlack),
    borderRadius: BorderRadius.circular(24.r),
  ),
  padding: EdgeInsets.all(15.h),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // From row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 18.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          Container(
            height: 18.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ],
      ),
      // Divider
      Container(
        height: 1.h,
        width: double.infinity,
        color: isDarkMode ? lightBlackColor : lightBlack,
      ),
      // Provider row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 18.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                height: 16.h,
                width: 16.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
          Container(
            height: 18.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ],
      ),
      // Max Slippage row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 18.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                height: 16.h,
                width: 16.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 18.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                height: 16.h,
                width: 16.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
        ],
      ),
      // Network Fee row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 18.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                height: 16.h,
                width: 16.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 18.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                height: 16.h,
                width: 16.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
)  ],
          ),
             ),
      ),
    );
  }
}
