import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Models/transection_model.dart';
import 'package:lnbg_crypto_wallet_app/Utils/app_utils.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/more_coin_details.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class TransferToken extends StatelessWidget {
final TokenData token;
final TransactionModel transection;
  const TransferToken(
      {super.key, required this.token, required this.transection,
     });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode?lightBlackColor3:whiteColor,
      appBar: const CustomAppBar(
       // isSuffix: true,
        title: "Transfer",
        iconPath: 'assets/icons/chat11.svg',
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "${transection.amount} ${transection.token}",
                style: GoogleFonts.urbanist(
                    color:isDarkMode?lightGreenColor: orange3,
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Center(
              child: Text(
                "${transection.amount*token.priceInUsd} USD",
                style: GoogleFonts.urbanist(
                    color:isDarkMode?greyColor: greyColor3,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const CustomDivider(),
            SizedBox(
              height: 20.h,
            ),
            Container(
            //  height: 224.h,
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
                        Flexible(
                          child: Padding(
                             padding:  EdgeInsets.only(left: 15.w),
                            child: Text(
                              formatDateTime("${transection.time}"),
                              style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: isDarkMode ? whiteColor : blackColor2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: isDarkMode ? lightBlackColor : lightBlack,
                    ),
                    SizedBox(height: 10.h,),
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
                        Flexible(
                          child: Padding(
                               padding:  EdgeInsets.only(left: 15.w),
                            child: Container(
                              //height: 24.h,
                              // width: 72.w,
                              decoration: BoxDecoration(
                                  color:isDarkMode?lightGreenColor.withValues(alpha:0.08): lightGreenColor.withValues(alpha:0.08),
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
                            ),
                          ),
                        )
                      ],
                    ),
                      SizedBox(height: 10.h,),
                     Container(
                      height: 1,
                      width: double.infinity,
                      color: isDarkMode ? lightBlackColor : lightBlack,
                    ),
                      SizedBox(height: 10.h,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        
                       // const Spacer(),
                        Flexible(
                          child: Padding(
                                padding:  EdgeInsets.only(left: 15.w),
                            child: Text(
                              shortenAddress(transection.to),
                              style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: isDarkMode ? whiteColor : blackColor2),
                            ),
                          ),
                        ),
                      ],
                    ),
                      SizedBox(height: 10.h,),
                     Container(
                      height: 1,
                      width: double.infinity,
                      color: isDarkMode ? lightBlackColor : lightBlack,
                    ),
                      SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                       // const Spacer(),
                        Flexible(
                          child: Padding(
                            padding:  EdgeInsets.only(left: 15.w),
                            child: Text(
                              textAlign: TextAlign.end,
                              transection.fee.toString(),
                              style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: isDarkMode ? whiteColor : blackColor2),
                            ),
                          ),
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
                      coinName: token.name,
                      tokenPrice: token.balance.toString(),
                      priceDolor: token.balanceInUsd.toString(),
                      tokenSuffix: token.symbol,
                      percentage: token.trendPercentage.toString(),
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
