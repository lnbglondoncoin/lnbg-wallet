import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/coin_chart.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class MoreCoinDetails extends StatelessWidget {
    final String coinName;
  final String tokenPrice;
  final String priceDolor;
  final String tokenSuffix;
  final String percentage;
  const MoreCoinDetails({super.key, required this.coinName, required this.tokenPrice, required this.priceDolor, required this.tokenSuffix, required this.percentage});

  @override
  Widget build(BuildContext context) {
     var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
backgroundColor:whiteColor,
        appBar: CustomAppBar(
          isSuffix: true,
          title:"Transfer" ,
          iconPath: 'assets/icons/chat2.svg',
        ),
        body: Padding(
          padding:  EdgeInsets.all(20.h),
          child: Column(
            children: [
               Center(
                child: Text(
                  tokenPrice,
                  style: GoogleFonts.urbanist(
                      color: orange3,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      priceDolor,
                      style: GoogleFonts.urbanist(
                          color: greyColor3,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 10.w,),
                    Text(
                  percentage,
                  style: GoogleFonts.urbanist(
                      color: orange5,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                  ],
                ),
                
              ),
              SizedBox(height: 20.h,),
              CustomDivider2(),
              SizedBox(height: 20.h,),
           SizedBox(
            height: 284.h,
            width: double.infinity,
            child:  ChartScreen(),
           )
            ],
          ),
        ),
    );
  }
}