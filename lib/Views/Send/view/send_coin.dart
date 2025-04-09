import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/controller/send_controllr.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_loading_spinner.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/patse_textfeild.dart';
import 'package:shimmer/shimmer.dart';

class SendCoin extends StatelessWidget {
  final TokenData token;
  SendCoin({
    super.key,
    required this.token,
  });
  final controller = Get.put(SendController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: CustomAppBar(
        title: "Send ${token.name}",
        isSuffix: true,
        iconPath: 'assets/icons/msg.svg',
      ),
      body: 
      Obx((){
        return 
        controller.isLoading.value
      ? _buildShimmerLayout(isDarkMode)
      :
        Form(
        key:controller.sendFormKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Column(
                    children: [
           CustomTextFieldWithPaste(
  controller: controller.addressController,
  validator: controller.validateAddress,
  hintText: "Recipient Address",
  iconPath: "assets/icons/scan2.svg",
  isDarkMode: isDarkMode,
  lightColor: lightWhiteColor,
  darkColor: lightBlackColor2,
  accentColor: isDarkMode ? lightGreenColor : orange4,
),   
  SizedBox(
                        height: 20.h,
                      ),
                      Obx(() {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: controller.isAmountEmpty.value
                                ? isDarkMode
                                    ? lightBlackColor2
                                    : lightWhiteColor
                                : lightGreenColor.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(18.r),
                            border: Border.all(
                              color: controller.isAmountEmpty.value
                                  ? isDarkMode
                                      ? lightBlackColor2
                                      : lightWhiteColor
                                  : isDarkMode
                                      ? lightGreenColor
                                      : orange3,
                            ),
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: controller.ammountController,
                                   validator: controller.validateAmount,
                                  onChanged: (value) {
                                    controller.updateAmount(
                                        value, token.priceInUsd);
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Amount ${token.symbol}",
                                    hintStyle: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.w400,
                                      color: greyColor2,
                                      fontSize: 18.sp,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                  ),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*')),
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  enableInteractiveSelection: false,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  "Max",
                                  style: GoogleFonts.urbanist(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800,
                                    color: isDarkMode ? lightGreenColor : orange4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      SizedBox(height: 30.h),
                      Obx(() {
                        return Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "Total Offer Amount: ${token.symbol} ${controller.ammountIncrypto.value.toStringAsFixed(10)} (${controller.ammountInUSD.value.toStringAsFixed(10)} USD)",
                            style: GoogleFonts.urbanist(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
                              color: isDarkMode ? greyColor : greyColor3,
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 20.h,
                      ),
                      const CustomDivider(),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recents",
                            style: GoogleFonts.urbanist(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode ? whiteColor : blackColor2),
                          ),
                          Text(
                            "Clear",
                            style: GoogleFonts.urbanist(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: isDarkMode ? lightGreenColor : orange4),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25.r,
                            backgroundImage:
                                const AssetImage("assets/images/g1.png"),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Flexible(
                            child: Text(
                              "0x7131CA84856...68de58848f8Ed83zmjshd,aCDJ",
                              style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: isDarkMode ? grey2 : darkGreyColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25.r,
                            backgroundImage:
                                const AssetImage("assets/images/g2.png"),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Flexible(
                            child: Text(
                              "0x7131CA84856...68de58848f8Ed83zmjshd,aCDJ",
                              style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: isDarkMode ? grey2 : darkGreyColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const CustomDivider(),
                SizedBox(
                  height: 200.h,
                )
              ],
            ),
          ),
        ),
      );
      }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(20.h),
        child: 
        Obx((){
          return controller.isLoading.value? const LoadingSpinner()
          : isDarkMode
            ? CustomGreenButton(
                buttonText: "Continue",
               onPressed: () async {
                  if (controller.validateForm()) {
              // Then execute the network fee calculation
              // controller.calculateNetworkFee(
              //   controller.selectedNetworkSpeed.value,
              //   token,
              //   false
              // );
              controller.calculateFees(
  cryptoAmount: controller.ammountIncrypto.value,
  cryptoAmountInUsd: controller.ammountInUSD.value,
  nativeTokenPriceInUsd: 1563,
    token: token
);
            }
                })
            : CustomButton(
                buttonText: "Continue",
                onPressed: () async {
                  if (controller.validateForm()) {
              // Then execute the network fee calculation
              // controller.calculateNetworkFee(
              //   controller.selectedNetworkSpeed.value,
              //   token,
              //   false
              // );
               controller.calculateFees(
  cryptoAmount: controller.ammountIncrypto.value,
  cryptoAmountInUsd: controller.ammountInUSD.value,
  nativeTokenPriceInUsd: 1484,
  token: token
);
            }
                });
        })
      ),
    );
  }


  Widget _buildShimmerLayout(bool isDarkMode) {
  return Shimmer.fromColors(
    baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
    highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            children: [
              // Address Input Shimmer
              Container(
                width: double.infinity,
                height: 58.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
              SizedBox(height: 20.h),

              // Amount Input Shimmer
              Container(
                width: double.infinity,
                height: 58.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
               SizedBox(height: 30.h),

              // Total Offer Amount Text Shimmer
              Container(
                width: 250.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 20.h),

              // Divider Shimmer
              Container(
                height: 1.h,
                color: Colors.white,
              ),
              SizedBox(height: 30.h),

              // Recents Header Shimmer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  Container(
                    width: 50.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Recent Items Shimmer
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Row(
                      children: [
                        // Avatar Shimmer
                        Container(
                          width: 50.w,
                          height: 50.w,
                           decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        // Address Text Shimmer
                        Expanded(
                          child: Container(
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const Spacer(),
         Container(
          height: 1.h,
          color: Colors.white,
        ),
        SizedBox(height: 200.h),
      ],
    ),
  );
}// Bottom Divider Shimmer
}
