import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';

class FingerPrintScanScreen extends StatelessWidget {
  const FingerPrintScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
  appBar: AppBar(
          backgroundColor: whiteColor,
          shadowColor: whiteColor,
          foregroundColor: whiteColor,
          surfaceTintColor: whiteColor,
          elevation: 0.0,
          centerTitle: true,
          leading: Padding(
            padding:  EdgeInsets.only(left: 10.w),
            child: SizedBox(
              height: 28.h,
              width: 28.w,
              child: Center(child: SvgPicture.asset(arrowLeft))),
          ),
            title: Text("Fingerprint Scan",style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: blackColor2
            ),),
            
        ),
        body: Padding(
          padding:  EdgeInsets.all(20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                "Please put your finger on the fingerprint scanner to get started.",style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: darkGreyColor
              ),),
              SizedBox(height: 30.h,),
              Image.asset("assets/images/fingerPrint.png",
              height: 300.h,
              width: 300.w,)
            ],
          ),
        ),
 floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        child: CustomButton(
            buttonText: "Continue",
            onPressed: () {
              // controller.isChecked.value
              //     ? controller.import()
              //     : Get.snackbar(
              //         backgroundColor: orange3,
              //         snackPosition: SnackPosition.TOP,
              //         "Attention",
              //         "Please accept terms and conditions");
            }),
      ),
    );
  }
}