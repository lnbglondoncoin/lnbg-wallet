import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/remind_me_latter_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_checkbox.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class AnimatedBottomSheet extends StatefulWidget {
  @override
  _AnimatedBottomSheetState createState() => _AnimatedBottomSheetState();
}

class _AnimatedBottomSheetState extends State<AnimatedBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start position (bottom of screen)
      end: Offset(0, 0), // End position (fully visible)
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.reverse(); // Animate closing before disposal
    _controller.dispose();
    super.dispose();
  }
    void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full-screen height
      backgroundColor: Colors.transparent, // Transparent background
      builder: (context) {
        return SkippedSecurityBottomSheet();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
       
        padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 25.w),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(49.r),
          topRight: Radius.circular(49.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "What is a “Seed phrase”?",style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: blackColor2
              ),),
            ),
            SizedBox(height: 20.h,),
            CustomDivider(),
            SizedBox(height: 20.h,),
            Text(
                "A seed phrase is a set of twelve words that contains all the information about your wallet, including your funds. It's like a secret code used to access your entire wallet.",style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: darkGreyColor
              ),),
              SizedBox(height: 20.h,),
            Text(
                "You must keep your seed phrase secret and safe. If someone gets your seed phrase, they'll gain control over your accounts.",style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: darkGreyColor
              ),),
              SizedBox(height: 20.h,),
               Text(
                "Save it in a place where only you can access it. If you lose it, not even LNBG Wallet can help you recover it.",style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: darkGreyColor
              ),),
              SizedBox(height: 20.h,),
              CustomDivider(),
              SizedBox(height: 20.h,),
           CustomButton(buttonText: "OK, I Got It", onPressed: (){
   Navigator.pop(context);
   _showCustomBottomSheet(context);
           }),
           SizedBox(height: 25.h,)
           
          ],
        ),
      ),
    );
  }
}





class SkippedSecurityBottomSheet extends StatefulWidget {
  @override
  _SkippedSecurityBottomSheetState createState() => _SkippedSecurityBottomSheetState();
}

class _SkippedSecurityBottomSheetState extends State<SkippedSecurityBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  final controller=Get.put(RemindMeLatterController());
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start position (bottom of screen)
      end: Offset(0, 0), // End position (fully visible)
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.reverse(); // Animate closing before disposal
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
       
        padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 25.w),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(49.r),
          topRight: Radius.circular(49.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "Skip Account Security?",style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: blackColor2
              ),),
            ),
            SizedBox(height: 20.h,),
            CustomDivider(),
            SizedBox(height: 20.h,),
            Row(
              children: [
                Obx((){
                  return  CustomCheckbox(
  isChecked: controller.isChecked.value,
  onChanged: (value) {
   controller .toggleCheckbox(!controller.isChecked.value);
  },
);
                }),
                SizedBox(width: 15.w,),
                Flexible(
                  child: Text(
                  
                      "I understand that if i lose my seed phrase i will not be able to access my wallet.",style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w800,
                      fontSize: 18.sp,
                      color: darkGreyColor,
                      height: 1.3.h
                    ),),
                ),
              ],
            ),
              
               
              SizedBox(height: 20.h,),
              CustomDivider(),
              SizedBox(height: 20.h,),
           Row(
            children: [
              Flexible(child: CustomLightGreenButton(buttonText: "No, Secure", onPressed: (){
                Navigator.pop(context);
              })),
              SizedBox(width: 15.w,),
               Flexible(child: CustomButton(buttonText: "Yes, Skip", onPressed: (){
               controller.isChecked.value? Navigator.pop(context):Get.snackbar("Attention", "Click the box to confirm",
               backgroundColor: orange3,
               snackPosition: SnackPosition.TOP);
               }))
            ],
           ),
           SizedBox(height: 25.h,)
           
          ],
        ),
      ),
    );
  }
}
