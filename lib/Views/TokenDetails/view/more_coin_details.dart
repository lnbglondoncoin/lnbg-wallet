import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/controller/token_details_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/coin_chart.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';

class MoreCoinDetails extends StatelessWidget {
    final String coinName;
  final String tokenPrice;
  final String priceDolor;
  final String tokenSuffix;
  final String percentage;
  const MoreCoinDetails({super.key, required this.coinName, required this.tokenPrice, required this.priceDolor, required this.tokenSuffix, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(TokenDetailsController());
     var theme = Theme.of(context);
   
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
backgroundColor:isDarkMode?lightBlackColor3:whiteColor,
        appBar: CustomAppBar(
        //  isSuffix: true,
          title:"$coinName Graph" ,
          iconPath: 'assets/icons/chat11.svg',
        ),
        body: SingleChildScrollView(
          padding:  EdgeInsets.all(20.h),
          child: Column(
            children: [
               Center(
                child: Text(
                  tokenPrice,
                  style: GoogleFonts.urbanist(
                      color:isDarkMode?lightGreenColor: orange3,
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
                          color:isDarkMode?greyColor: greyColor3,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 10.w,),
                    Text(
                  percentage,
                  style: GoogleFonts.urbanist(
                      color:isDarkMode?lightGreenColor: orange5,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                  ],
                ),
                
              ),
              SizedBox(height: 20.h,),
              const CustomDivider(),
              SizedBox(height: 20.h,),
           SizedBox(
            height: 284.h,
          
            width: double.infinity,
            child:  const ChartScreen(),
           ),
           SizedBox(
            height:20.h
           ),
           Container(
            height: 172.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(24.r),
              border: Border.all(
                color:isDarkMode?lightBlackColor: lightBlack
              )
              
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                    "Price Alerts",
                    style: GoogleFonts.urbanist(
                        color:isDarkMode?greyColor: darkGreyColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                 CustomSwitch(isSwitched: controller.isSwitched1),
                    ],
                  ),
                  const CustomDivider(),
                   Row(
                   
                    children: [
                      Text(
                    "Website",
                    style: GoogleFonts.urbanist(
                        color:isDarkMode?greyColor: darkGreyColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  Text(
                    "ethereum.org",
                    style: GoogleFonts.urbanist(
                        color:isDarkMode?whiteColor: darkGreyColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 10.w,),
                  SvgPicture.asset("assets/icons/arrowRight.svg",
                     colorFilter: ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn))
                    ],
                  ),
                  const CustomDivider(),
                    Row(
                   
                    children: [
                      Text(
                    "Explorer",
                    style: GoogleFonts.urbanist(
                        color:isDarkMode?greyColor: darkGreyColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  Text(
                    "etherscan.io",
                    style: GoogleFonts.urbanist(
                        color:isDarkMode?whiteColor: darkGreyColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 10.w,),
                  SvgPicture.asset("assets/icons/arrowRight.svg",
                  colorFilter: ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn),
                  )
                    ],
                  ),
                 
                ],
              ),
            ),
           ),
            SizedBox(
            height:20.h
           ),
           Container(
            height: 172.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(24.r),
              border: Border.all(
             color:isDarkMode?lightBlackColor: lightBlack
              )
              
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                    "Market Cap",
                    style: GoogleFonts.urbanist(
                        color:isDarkMode?greyColor: darkGreyColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                
                  Flexible(
                    child: Text(
                        textDirection:TextDirection.rtl,
                      "\$164,387,883,628",
                      style: GoogleFonts.urbanist(
                          color: isDarkMode?whiteColor: darkGreyColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                 
                    ],
                  ),
                  const CustomDivider(),
                   Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                    "Volume (24h)",
                    style: GoogleFonts.urbanist(
                        color:isDarkMode?greyColor: darkGreyColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                
                  Flexible(
                    child: Text(
                        textDirection:TextDirection.rtl,
                      "\$13,634,523,467",
                      style: GoogleFonts.urbanist(
                          color:isDarkMode?whiteColor: darkGreyColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                 
                    ],
                  ),
                  const CustomDivider(),
                    Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                    "Circulating Supply",
                    style: GoogleFonts.urbanist(
                        color:isDarkMode?greyColor: darkGreyColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                
                  Flexible(
                    child: Text(
                      textDirection:TextDirection.rtl,
                      "122,587,625.50 ETH",
                      style: GoogleFonts.urbanist(
                          color:isDarkMode?whiteColor: darkGreyColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                 
                    ],
                  ),
                 
                ],
              ),
            ),
           ),
           SizedBox(height: 30.h,)
         
            ],
          ),
        ),
    );
  }
}