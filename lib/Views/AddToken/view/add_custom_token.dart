import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/AddToken/controller/add_token_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/AddToken/view/search_network.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_textfeild.dart';

class AddCustomToken extends StatelessWidget {
  const AddCustomToken({super.key});

  @override
  Widget build(BuildContext context) {
            var theme = Theme.of(context);
    var textTheme = theme.textTheme;
     final controller=Get.put(AddTokenController());
       bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: "Add Custom Token", iconPath: ""),
      body: Padding(
        padding:  EdgeInsets.all(20.h),
        child: Column(
          children: [
            Container(
             // height: 408.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: lightBlack
                )
              ),
              child: Padding(
                padding:  EdgeInsets.all(15.h),
                child: Column(
                  children: [
                GestureDetector(
                  onTap: (){
                    Get.to(()=>SearchNetworkScreen());
                  },
                  child: Row(
                    children: [
                      Text("Network",style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w700,
                        color: blackColor2,
                        fontSize: 20.sp
                      ),),
                      Spacer(),
                     Obx((){
                      return  Text(controller.selectedNetwork.value,style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w700,
                        color: blackColor2,
                        fontSize: 20.sp
                      ),);
                     }),
                      SizedBox(width: 10.w,),
                      SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: Center(
                          child: SvgPicture.asset("assets/icons/arrowRight.svg"),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15.h,),
                CustomDivider2(),
                SizedBox(height: 15.h,),
                          Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color:isDarkMode?lightBlackColor2: lightWhiteColor,
                    borderRadius: BorderRadius.circular(18.r)),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Contract Address",
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
                CustomTextField(hintText: "Name", controller: TextEditingController(), labelText: ""),
                  CustomTextField(hintText: "Symbol", controller: TextEditingController(), labelText: ""),
                  CustomTextField(hintText: "Decimals", controller: TextEditingController(), labelText: "")
          
                
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Container(
              height: 84.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(14.r),
                color: orange6.withOpacity(0.2)
              ),
              child: Padding(
                padding:  EdgeInsets.all(8.h),
                child: Row(
                  children: [
                    Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: orange5
                      ),
                      child: Center(
                        child: Text("!",style: GoogleFonts.urbanist(
                          color: whiteColor,
                          fontWeight: FontWeight.w800
                        ),),
                      ),
                
                    ),
                    SizedBox(width: 10.w,),
                     Flexible(
                       child: Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        "Anyone can create token, including a fake versions of existing tokens. Learn more about scams and security risks.",style: GoogleFonts.urbanist(
                            color: orange5,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),),
                     ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h,),
             Text(
                        "What is Custom Token?",style: GoogleFonts.urbanist(
                            color: orange3,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700
                          ),),
          
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border(
          top: BorderSide(
              color: greyColor4
          )
          )
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width/2.5,vertical: 20.h),
          child: CustomButton(buttonText: "Ok", onPressed: (){}),
        ),
      ),
    );
  }
}