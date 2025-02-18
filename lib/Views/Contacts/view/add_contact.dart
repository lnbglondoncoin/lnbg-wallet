import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_textfeild.dart';

class AddContact extends StatelessWidget {
  const AddContact({super.key});

  @override
  Widget build(BuildContext context) {
     var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(title: "Add Contact", iconPath: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(hintText: "Jenny Wilson", controller: TextEditingController(), labelText: "Name"),
                                  SizedBox(height: 15.h,),
                                   Text(
              "Address",
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color:isDarkMode?whiteColor: blackColor2,
              ),
            ),
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
              SizedBox(height: 15.h,),
                  CustomTextField(hintText: "Memo", controller: TextEditingController(), labelText: "Memo")
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding:  EdgeInsets.all(20.h),
        child: CustomButton(buttonText: "Add Contact", onPressed: (){}),
      ),
    );
  }
}