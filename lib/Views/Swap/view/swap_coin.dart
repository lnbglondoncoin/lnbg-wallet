import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class SwapCoinScreen extends StatelessWidget {
  const SwapCoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
     var theme = Theme.of(context);

       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
       backgroundColor:  isDarkMode?lightBlackColor3:whiteColor,
        appBar: CustomAppBar(
          title: "Swap",
          iconPath: 'assets/icons/search.svg',
        ),
        body: Padding(
          padding:  EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SizedBox(
                    height: 48.h,
                    width: 48.w,
                    child: Image.asset("assets/icons/etg.png",height: 48.h,
                    width: 48.w,),
                  
                    ),
                  title: Text("0.855 ETH",style: GoogleFonts.urbanist(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color:isDarkMode?whiteColor: blackColor2
                  ),),
                  subtitle:  Text("TRC20",style: GoogleFonts.urbanist(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color:isDarkMode?greyColor: blackColor2
                  ),),
                    
                ),
                SizedBox(height: 10.h,),
                SizedBox(height: 24.h,width: 48.w,
                child: Center(
                  child: SvgPicture.asset("assets/icons/arrowDown.svg",
                  
                  colorFilter: ColorFilter.mode(isDarkMode?whiteColor:greyColor, BlendMode.srcIn),),
                ),),
                  SizedBox(height: 10.h,),
                 ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SizedBox(
                    height: 48.h,
                    width: 48.w,
                    child: Image.asset("assets/icons/tether.png",height: 48.h,
                    width: 48.w,),
                  
                    ),
                  title: Text("0.855 ETH",style: GoogleFonts.urbanist(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color:isDarkMode?whiteColor: blackColor2
                  ),),
                  subtitle:  Text("TRC20",style: GoogleFonts.urbanist(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color:isDarkMode?greyColor: blackColor2
                  ),),
                    
                ),
                SizedBox(height: 30.h,),
                Container(
                  height: 224.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDarkMode?lightBlackColor2:whiteColor,
                    border: Border.all(
                      color:isDarkMode?lightBlackColor:
                       lightBlack
                    ),
                    borderRadius: BorderRadius.circular(24.r)
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(15.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           Text("From",style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color:isDarkMode?greyColor: darkGreyColor
                    ),),
                    Text("Wallet (0x7131C...f8E696)",style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color:isDarkMode?whiteColor: blackColor2
                    ),), 
                          ],
                        ),
                        //SizedBox(height: 25.h,),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color:isDarkMode?lightBlackColor: lightBlack,
                        ),
                         // SizedBox(height: 25.h,),
                           Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           Row(
                             children: [
                               Text("Provider",style: GoogleFonts.urbanist(
                                                     fontSize: 18.sp,
                                                     fontWeight: FontWeight.w800,
                                                     color:isDarkMode?greyColor: darkGreyColor
                                                   ),),
                                                   SizedBox(width: 10.w,),
                                                   SizedBox(
                                                    height: 16.h,
                                                    width: 16.w,
                                                    child: Center(child: SvgPicture.asset("assets/icons/eyeButton.svg")))
                             ],
                           ),
                    Text("1inch Network",style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color:isDarkMode?whiteColor: blackColor2
                    ),), 
                          ],
                        ),
                         Row(
                         
                          children: [
                           Row(
                             children: [
                               Text("Max Slippage",style: GoogleFonts.urbanist(
                                                     fontSize: 18.sp,
                                                     fontWeight: FontWeight.w800,
                                                     color:isDarkMode?greyColor: darkGreyColor
                                                   ),),
                                                     SizedBox(width: 10.w,),
                                                    SizedBox(
                                                    height: 16.h,
                                                    width: 16.w,
                                                    child: Center(child: SvgPicture.asset("assets/icons/eyeButton.svg")))
                             ],
                           ),
                           Spacer(),
                             
                    Text("2%",style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color:isDarkMode?whiteColor: blackColor2
                    ),), 
                      SizedBox(width: 8.w,),
                                                    SizedBox(
                                                    height: 16.h,
                                                    width: 16.w,
                                                    child: Center(child: SvgPicture.asset("assets/icons/Edit.svg",colorFilter: 
                                                    ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn),))),
                          ],
                        ),
                         Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           Row(
                             children: [
                               Text("Network Fee",style: GoogleFonts.urbanist(
                                                     fontSize: 18.sp,
                                                     fontWeight: FontWeight.w800,
                                                     color:isDarkMode?greyColor: darkGreyColor
                                                   ),),
                                                       SizedBox(width: 10.w,),
                                                    SizedBox(
                                                    height: 16.h,
                                                    width: 16.w,
                                                    child: Center(child: SvgPicture.asset("assets/icons/eyeButton.svg"))) 
                             ],
                           ),
                           Spacer(),
                    Text("0.025 ETH",style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color:isDarkMode?whiteColor: blackColor2
                    ),), 
                      SizedBox(width: 8.w,),
                                                    SizedBox(
                                                    height: 16.h,
                                                    width: 16.w,
                                                    child: Center(child: SvgPicture.asset("assets/icons/Edit.svg",colorFilter: 
                                                    ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn),))),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color:isDarkMode?lightBlackColor: greyColor4
              )
            )
          ),
          child: Padding(
            padding:  EdgeInsets.all(20.h),
            child:isDarkMode? CustomGreenButton(buttonText: "Confirm", onPressed: (){
              _showSuccesPopup(context);
            }): CustomButton(buttonText: "Confirm", onPressed: (){
              _showSuccesPopup(context);
            }),
          ),
        ),
    );
  }
     void _showSuccesPopup(BuildContext context) {
      var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
          backgroundColor:isDarkMode?lightBlackColor2: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon: Image.asset(
           isDarkMode? "assets/images/swap_success2.png": "assets/images/swap_success.png",
            height: 180.h,
            width: 186.w,
          ),
          title: Text(
            "Successful Swap!",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp, fontWeight: FontWeight.w700, color: isDarkMode?lightGreenColor:orange3),
          ),
          content: Text(
              textAlign: TextAlign.center,
              "Your crypto was swap successfully. You can view more details below.",
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode?whiteColor: blackColor2)),
          actions: [
         isDarkMode?CustomGreenButton(buttonText: "View Details", onPressed: (){
          Navigator.pop(context);
         }):
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 58.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    gradient: const LinearGradient(colors: [orange2, orange1])),
                child: Center(
                  child: Text(
                    "View Details",
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: whiteColor),
                  ),
                ),
              ),
            ),
           
          SizedBox(
              height: 15.h,
            ),
            CustomLightGreenButton(
                buttonText: "Cancel",
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

}