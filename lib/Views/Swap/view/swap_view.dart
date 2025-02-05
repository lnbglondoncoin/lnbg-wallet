import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/view/swap_coin.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class SwapView extends StatelessWidget {
  const SwapView({super.key});

  @override
  Widget build(BuildContext context) {
          var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: "Swap",
          iconPath: 'assets/icons/search.svg',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),
            child: Column(
              children: [
                Container(
                //  height: 288.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    color:
                    isDarkMode?lightBlackColor2:
                     whiteColor,border: Border.all(
                    color:
                    isDarkMode?lightBlackColor:
                    lightBlack)
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("You Pay",style: GoogleFonts.urbanist(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color:isDarkMode?greyColor: darkGreyColor
                      ),),
                      Row(children: [
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "|Enter balance",
                              hintStyle: GoogleFonts.urbanist(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color:isDarkMode?greyColor.withOpacity(0.5): greyColor
                              )
                            ),
                            style: GoogleFonts.urbanist(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color:isDarkMode?whiteColor: blackColor2
                              ),
                          ),
                        ),
                        //Spacer(),
                        SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: Center(
                            child: Image.asset("assets/icons/etg.png"),
                          ),
                        ),
                         SizedBox(width: 5.w,),
                        Text("ETH",style:GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color:isDarkMode?whiteColor: blackColor2
                        ) ,),
                        SizedBox(width: 5.w,),
                        SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: Center(
                            child: SvgPicture.asset("assets/icons/arrowRight.svg",colorFilter: 
                                ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn),),
                          ),
                        ),

                      ],),
                      Text("Balance: 59.47 ETH",style: GoogleFonts.urbanist(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color:isDarkMode?greyColor: darkGreyColor
                      ),),
                      SizedBox(height: 20.h,),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width/1.9,
                          child:  Container(
                            height: 1,
                            width: double.infinity,
                            color:isDarkMode?lightBlackColor: lightBlack,
                          )
                        ),
                        SizedBox(width: 8.w,),
                        Container(height: 44.h,
                        width: 44.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lightGreenColor.withOpacity(0.08)
                        ),
                         child: Center(
                                child: SvgPicture.asset("assets/icons/doubleArrow.svg",colorFilter: 
                                ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn),),
                              ),
                        ),
                         SizedBox(width: 8.w,),
                         Flexible(
                           child: Container(
                              height: 1,
                             // width: double.infinity,
                              color:isDarkMode?lightBlackColor: lightBlack,
                             
                            ),
                         )
                      ],
                    ),
                    SizedBox(height: 20.h,),
                     Text("You Get",style: GoogleFonts.urbanist(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                         color:isDarkMode?greyColor: darkGreyColor
                      ),),
                      Row(children: [
                       Text("0",style: GoogleFonts.urbanist(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: greyColor
                              ),),
                        Spacer(),
                        SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: Center(
                            child: Image.asset("assets/icons/tether.png"),
                          ),
                        ),
                         SizedBox(width: 5.w,),
                        Text("USDT",style:GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color:isDarkMode?whiteColor: blackColor2
                        ) ,),
                        SizedBox(width: 5.w,),
                        SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: Center(
                            child: SvgPicture.asset("assets/icons/arrowRight.svg",colorFilter: 
                                ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn),),
                          ),
                        ),

                      ],),
                      Text("Balance: 59.47 ETH",style: GoogleFonts.urbanist(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color:isDarkMode?greyColor: darkGreyColor
                      ),),
             ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
               Row(
                children: [
                   Flexible(
                     child: Container(height: 32.h,
                                     
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(100.r),
                                       border: Border.all(color:isDarkMode?lightGreenColor: orange3,width: 2)
                                     ),
                                     child: Center(
                                       child: Text("25%",style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color:isDarkMode?lightGreenColor: orange3
                                       ),),
                                     ),
                                     ),
                   ),
                   SizedBox(width: 10.w,),
                    Flexible(
                     child: Container(height: 32.h,
                                     
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(100.r),
                                       border: Border.all( color:isDarkMode?lightGreenColor: orange3,width: 2)
                                     ),
                                     child: Center(
                                       child: Text("50%",style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color:isDarkMode?lightGreenColor: orange3
                                       ),),
                                     ),
                                     ),
                   ),
                   SizedBox(width: 10.w,),
                    Flexible(
                     child: Container(height: 32.h,
                                     
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(100.r),
                                       border: Border.all( color:isDarkMode?lightGreenColor: orange3,width: 2)
                                     ),
                                     child: Center(
                                       child: Text("75%",style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color:isDarkMode?lightGreenColor: orange3
                                       ),),
                                     ),
                                     ),
                   ),
                   SizedBox(width: 10.w,),
                    Flexible(
                     child: Container(height: 32.h,
                                     
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(100.r),
                                       border: Border.all( color:isDarkMode?lightGreenColor: orange3,width: 2)
                                     ),
                                     child: Center(
                                       child: Text("100%",style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                       color:isDarkMode?lightGreenColor: orange3
                                       ),),
                                     ),
                                     ),
                   )
                ],
               ),
               SizedBox(height: 20.h,),
                Text("1 ETH = \$1,334.2 USDT%",style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color:isDarkMode?greyColor: darkGreyColor
                                       ),),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding:  EdgeInsets.all(20.h),
          child: isDarkMode?CustomGreenButton(buttonText: "Swap", onPressed: (){
            Get.to(()=>SwapCoinScreen());
          }):CustomButton(buttonText: "Swap", onPressed: (){
            Get.to(()=>SwapCoinScreen());
          }),
        ),
    );
  }
}