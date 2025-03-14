import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/controller/send_controllr.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class EditNetworkScreen extends StatelessWidget {
  final TokenData token;
  EditNetworkScreen({super.key, required this.token});
  final controller = Get.put(SendController());
  @override
  Widget build(BuildContext context) {
        var theme = Theme.of(context);
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
     backgroundColor: isDarkMode?lightBlackColor3:whiteColor,
      appBar: const CustomAppBar(
        title: "Edit Network Fee",
        iconPath: 'assets/icons/search.svg',
        isSuffix: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Basic",
                style: GoogleFonts.urbanist(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode?whiteColor: blackColor2),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "The network fee covers the cost of processing your transaction on the Ethereum network.",
                style: GoogleFonts.urbanist(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color:isDarkMode?whiteColor: darkGreyColor),
              ),
              SizedBox(
                height: 15.h,
              ),
              ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: Obx(() {
                          return GestureDetector(
                            onTap: () async {
                            
                              controller.changeSelectedSpeed(index,networkSpeedList[index],token);
                              
                            },
                            child: Container(
                              //height: 82.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                      color: index ==
                                              controller.selectedSpeed.value
                                          ?isDarkMode?lightGreenColor: orange3
                                          :isDarkMode?lightBlackColor: greyColor,
                                      width: 1)),
                              child: Padding(
                                padding: EdgeInsets.all(15.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      networkSpeedList[index],
                                      style: GoogleFonts.urbanist(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color:isDarkMode?whiteColor: blackColor2),
                                    ),
                                    Column(
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
    /// Wrapping Fee Text with a fixed width
    Container(
      width: 100.w, // Adjust width as per your layout
      child: Text(
        index == 0
            ? "${controller.networkFee.value} ${token.symbol}"
            : index == 1
                ? "${controller.moderateNetworkFee.value} ${token.symbol}"
                : "${controller.fastNetworkFee.value} ${token.symbol}",
        maxLines: 2,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.right, // Ensures proper alignment
        style: GoogleFonts.urbanist(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: isDarkMode ? whiteColor : blackColor2,
        ),
      ),
    ),

    SizedBox(height: 5.h),

    /// Wrapping USD Fee Text
    Container(
      width: 100.w, // Adjust width as needed
      child: Text(
        index == 0
            ? "\$${controller.networkFeeUsd.value}"
            : index == 1
                ? "\$${controller.moderateNetworkFeeUsd.value}"
                : "\$${controller.fastNetworkFeeUSD.value}",
        maxLines: 2,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.right,
        style: GoogleFonts.urbanist(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? greyColor : greyColor3,
        ),
      ),
    ),
  ],
),

                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
                  }),
              SizedBox(
                height: 10.h,
              ),
              const CustomDivider(),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Advanced",
                style: GoogleFonts.urbanist(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color:isDarkMode?whiteColor: blackColor2),
              ),
              SizedBox(
                height: 20.h,
              ),
              ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 15.h),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                        decoration: BoxDecoration(
                          color: isDarkMode ? lightBlackColor2 : lightWhiteColor,
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        child: Obx((){
                          return Text(
                          index == 0 
                            ? controller.maxFee.value 
                            : index == 1 
                              ? controller.gasLimit.value 
                              : controller.nonce.value,
                          style: GoogleFonts.urbanist(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: isDarkMode ? whiteColor : blackColor2,
                          ),
                        );
                        })
                      ),
                    );
                  }),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(20.h),
        child: isDarkMode? CustomGreenButton(buttonText: "Ok", onPressed: () {
          Get.back();
        }): CustomButton(buttonText: "Ok", onPressed: () async {
       await controller. calculateNetworkFee(controller.selectedNetworkSpeed.value,token,true);

        
        })
      ),
    );
  }
}
