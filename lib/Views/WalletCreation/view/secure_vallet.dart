import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/wallet_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/secure_wallet_2.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_step_app_bar.dart';

class SecureWalletScreen extends StatelessWidget {
   SecureWalletScreen({super.key});
    final StepController controller = Get.put(StepController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,

      appBar:CustomStepAppBar(
        onBackTap: () {
         controller.decreseIndexValue(1);
              Get.back();
        },
        currentIndex: controller.currentIndex, onWillPop: () { 
           controller.decreseIndexValue(1);
              Get.back();
         }, // Pass the RxInt
      ),
   body: Column(
       
        children: [
          Padding(
            padding:  EdgeInsets.all(25.h),
            child: const CustomDivider(),
          ),
          /// First section (Image) - Takes 3/8 (1.5/4) of available space
          Expanded(
            flex: 4,
            child: Center(
              child: Image.asset(
                "assets/images/wallet3.png",
                width: 350.w,
              ),
            ),
          ),
    SizedBox(height: 25.h,),
          /// Second section (Text & Buttons) - Takes 5/8 (2.5/4) of available space
          Expanded(
            flex: 6,
            child: Padding(
               padding: EdgeInsets.only(bottom:20.h,left: 
           25.w,right: 25.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Secure Your Wallet",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: darkPrimaryColor,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 20.h),
                 RichText(
  textAlign: TextAlign.center,
  text: TextSpan(
    text: "Don't risk losing your funds. Protect your wallet by saving your ",
    style:  GoogleFonts.urbanist(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: darkGreyColor,
                      height: 1.3,
                    ),
    children: [
      TextSpan(
        text: "Seed phrase",
        style:  GoogleFonts.urbanist(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: orange3,
                      height: 1.3,
                    ),
      ),
      TextSpan(
        text: " in a place you trust.",
        style: GoogleFonts.urbanist(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: darkGreyColor,
                      height: 1.3,
                    ),
      ),
    ],
  ),
),

                  SizedBox(height: 10.h,),
                   Text(
                    "It's the only way to recover your wallet if you get locked out of the app or get a new device.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: darkGreyColor,
                      height: 1.3,
                    ),),
                  SizedBox(height: 40.h),
                 
                ],
              ),
            ),
          ),
        ],
      ),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
   floatingActionButton: Padding(
     padding:  EdgeInsets.symmetric(horizontal: 25.w),
     child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
     
      children: [
         CustomButton(
                      buttonText: "Start",
                      onPressed: () {
                      Get.to(()=> SecureWallet2());
                      },
                    ),
                    SizedBox(height: 25.h),
                    CustomLightGreenButton(
                      buttonText: "Remind Me Later",
                      onPressed: () {},
                    ),
      ],
     ),
   ),
    );
  }
  Widget buildStep(int index) {
    final StepController controller = Get.find();
    bool isActive = controller.currentIndex.value >= index;

    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isActive
            ? const LinearGradient(
                colors: [
                  Color(0xFFFFE580),
                  Color(0xFFFACC15),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isActive ? null : greyColor, // Default color for inactive steps
      ),
    );
  }

  Widget buildLine(int index) {
    final StepController controller = Get.find();
    bool isActive = controller.currentIndex.value >= index;

    return Expanded(
      child: Container(
        height: 4.h,
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [primaryColor, lightPrimaryColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color:
              isActive ? null : greyColor, // Default color for inactive lines
        ),
      ),
    );
  }



}