import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/controller/send_controllr.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class EditNetworkScreen extends StatelessWidget {
  final String coinCode;
  EditNetworkScreen({super.key, required this.coinCode});
  final controlelr = Get.put(SendController());
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
                            onTap: () {
                              controlelr.changeSelectedSpeed(index);
                            },
                            child: Container(
                              height: 82.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                      color: index ==
                                              controlelr.selectedSpeed.value
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${networkSpeedpriceWithcode[index]} $coinCode",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                              color:isDarkMode?whiteColor: blackColor2),
                                        ),
                                        Text(
                                          networkSpeedpriceInDolors[index],
                                          style: GoogleFonts.urbanist(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color:isDarkMode?greyColor: greyColor3),
                                        ),
                                      ],
                                    )
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
                        height: 58.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color:isDarkMode?lightBlackColor2: lightWhiteColor,
                            borderRadius: BorderRadius.circular(18.r)),
                        child:
                        TextField(
                        cursorColor: isDarkMode?lightGreenColor:orange3,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                        
                          border: InputBorder.none,
                          hintText: networkAdvance[index],
                          hintStyle: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: greyColor2),
                         
                        ))
                        //  Padding(
                        //   padding: EdgeInsets.all(15.h),
                        //   child: Text(
                        //     networkAdvance[index],
                        //     style: GoogleFonts.urbanist(
                        //         fontSize: 18.sp,
                        //         fontWeight: FontWeight.w400,
                        //         color: greyColor2),
                        //   ),
                        // ),
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
        child: isDarkMode? CustomGreenButton(buttonText: "Ok", onPressed: () {}): CustomButton(buttonText: "Ok", onPressed: () {})
      ),
    );
  }
}
