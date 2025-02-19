import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/more_coin_details.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class TransferToken extends StatelessWidget {
  final String coinName;
  final String tokenPrice;
  final String priceDolor;
  final String tokenSuffix;
  final String percentage;
  const TransferToken(
      {super.key,
      required this.tokenPrice,
      required this.priceDolor,
      required this.tokenSuffix,
      required this.percentage,
      required this.coinName});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode?lightBlackColor3:whiteColor,
      appBar: CustomAppBar(
        isSuffix: true,
        title: "Transfer",
        iconPath: 'assets/icons/chat11.svg',
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            Center(
              child: Text(
                "$tokenPrice $tokenSuffix",
                style: GoogleFonts.urbanist(
                    color:isDarkMode?lightGreenColor: orange3,
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Center(
              child: Text(
                "$priceDolor USD",
                style: GoogleFonts.urbanist(
                    color:isDarkMode?greyColor: greyColor3,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomDivider(),
            SizedBox(
              height: 20.h,
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
                          "Date",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: isDarkMode ? greyColor : darkGreyColor),
                        ),
                        Text(
                          "Dec 24, 09:41 AM",
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
                    // SizedBox(height: 25.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Status",
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
                        Container(
                          //height: 24.h,
                          // width: 72.w,
                          decoration: BoxDecoration(
                              color:isDarkMode?lightGreenColor.withOpacity(0.08): lightGreenColor.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(
                                8.r,
                              )),
                          child: Padding(
                            padding: EdgeInsets.all(8.h),
                            child: Text(
                              "Completed",
                              style: GoogleFonts.urbanist(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w800,
                                  color:isDarkMode?lightGreenColor: orange3),
                            ),
                          ),
                        )
                      ],
                    ),
                     Container(
                      height: 1,
                      width: double.infinity,
                      color: isDarkMode ? lightBlackColor : lightBlack,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Receiver",
                              style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color:
                                      isDarkMode ? greyColor : darkGreyColor),
                            ),
                          ],
                        ),
                        
                        Spacer(),
                        Text(
                          "0x16dcc0e...bf7c61037",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: isDarkMode ? whiteColor : blackColor2),
                        ),
                      ],
                    ),
                     Container(
                      height: 1,
                      width: double.infinity,
                      color: isDarkMode ? lightBlackColor : lightBlack,
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
                        Spacer(),
                        Text(
                          "0.025 ETH",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: isDarkMode ? whiteColor : blackColor2),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => MoreCoinDetails(
                      coinName: coinName,
                      tokenPrice: tokenPrice,
                      priceDolor: priceDolor,
                      tokenSuffix: tokenSuffix,
                      percentage: percentage,
                    ));
              },
              child: Text(
                "View More Details",
                style: GoogleFonts.urbanist(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color:isDarkMode?lightGreenColor: orange3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
