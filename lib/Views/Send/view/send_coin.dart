import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/controller/send_controllr.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/confir_send_coin.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class SendCoin extends StatelessWidget {
  final TokenData token;
  SendCoin({super.key, required this.token, });
  final controller = Get.put(SendController());
  @override
  Widget build(BuildContext context) {
        var theme = Theme.of(context);
       bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
      backgroundColor: isDarkMode?lightBlackColor3:whiteColor,
      appBar: CustomAppBar(
        title: "Send ${token.name}",
        isSuffix: true,
        iconPath: 'assets/icons/msg.svg',
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color:isDarkMode?lightBlackColor2: lightWhiteColor,
                          borderRadius: BorderRadius.circular(18.r)),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: controller.addressController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Recipient Address",
                                  hintStyle: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.w400,
                                      color: greyColor2,
                                      fontSize: 18.sp),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15.w)),
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w400,
                                  color:isDarkMode?whiteColor: blackColor2,
                                  fontSize: 18.sp),
                            ),
                          ),
                          Text(
                            "Paste",
                            style: GoogleFonts.urbanist(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color:isDarkMode?lightGreenColor: orange4),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(
                                  "assets/icons/scan2.svg",
                                  colorFilter:  ColorFilter.mode(
                                     isDarkMode?lightGreenColor: orange4, BlendMode.srcIn),
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(() {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: controller.isAmountEmpty.value
                              ?isDarkMode?lightBlackColor2: lightWhiteColor
                              : lightGreenColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(
                            color: controller.isAmountEmpty.value
                                ? isDarkMode?lightBlackColor2:lightWhiteColor
                                :isDarkMode?lightGreenColor: orange3,
                          ),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: controller.ammountController,
                                onChanged: (value) {
                                  controller.updateAmount(value, token.priceInUsd);
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
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
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
                                  color:isDarkMode?lightGreenColor: orange4,
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
      "Total Offer Amount: ${token.symbol} ${controller.ammountIncrypto.value.toStringAsFixed(10) } (${ controller.ammountInUSD.value.toStringAsFixed(10)} USD)",
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
                              color:isDarkMode?whiteColor: blackColor2),
                        ),
                        Text(
                          "Clear",
                          style: GoogleFonts.urbanist(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
                              color:isDarkMode?lightGreenColor: orange4),
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
                          backgroundImage: const AssetImage("assets/images/g1.png"),
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
                                color:isDarkMode?grey2: darkGreyColor),
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
                          backgroundImage: const AssetImage("assets/images/g2.png"),
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
                                color:isDarkMode?grey2:  darkGreyColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
           Spacer(),
           CustomDivider(),
           SizedBox(height: 200.h,)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(20.h),
        child: isDarkMode? CustomGreenButton(
            buttonText: "Continue",
            onPressed: () async{
if(controller.ammountController.text!="0"){
await controller.calculateNetworkFee(controller.selectedNetworkSpeed.value,token,false);
}
else{
  Get.snackbar("Error", "Amount cannot be zero");
}
  
               
            }): CustomButton(
            buttonText: "Continue",
            onPressed: () async{
        if(controller.ammountController.text!="0"){
await controller.calculateNetworkFee(controller.selectedNetworkSpeed.value,token,false);
}
else{
  Get.snackbar("Error", "Amount cannot be zero");
}
  
            }),
      ),
    );
  }
}
