import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lnbg_crypto_wallet_app/Utils/phone_number_validator.dart';

class InviteFriendController extends GetxController {
  
Future<void> inviteContact(String phoneNumber) async {
  print(phoneNumber);

  if (!GetUtils.isPhoneNumber(phoneNumber)) {
    _showFailPopup(Get.context!, "The phone number provided is not valid. Please check and try again.");
    return;
  }

  const dummyLink = "https://example.com/invite";
  final whatsappUrl = "https://wa.me/$phoneNumber?text=$dummyLink";
  final smsUrl = "sms:$phoneNumber?body=$dummyLink";
 _showSuccesPopup(Get.context!,whatsappUrl,smsUrl);

}

  // Future<void> inviteContact(String phoneNumber) async {
  //   print(phoneNumber);
  //   if (!GetUtils.isPhoneNumber(phoneNumber)) {
  //     _showFailPopup(Get.context!,"The phone number provided is not valid. Please check and try again.");
     
  //     return;
  //   }

  //   const dummyLink = "https://example.com/invite";
  //   final whatsappUrl = "https://wa.me/$phoneNumber?text=$dummyLink";
  //   final smsUrl = "sms:$phoneNumber?body=$dummyLink";

 
  //   // Check if WhatsApp can be launched
  //   if (await canLaunch(whatsappUrl)) {
  //     await launch(whatsappUrl);
  //   } else if (await canLaunch(smsUrl)) {
  //     // Fallback to SMS if WhatsApp is not available
  //     await launch(smsUrl);
  //   } else {
  //     Get.snackbar("Error", "Unable to send invite to $phoneNumber");
  //     Get.back();
  //   }
  // }


   void _showFailPopup(BuildContext context, String message) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
          backgroundColor: isDarkMode ? lightBlackColor2 : whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon: Image.asset(
            isDarkMode ? "assets/images/fail2.png" : "assets/images/fail.png",
            height: 180.h,
            width: 186.w,
          ),
          title: Text(
            "Oops.. .Failed!",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp, fontWeight: FontWeight.w700, color: pinkColor),
          ),
          content: Text(
              textAlign: TextAlign.center,
              message,
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? whiteColor : blackColor2)),
          actions: [
            isDarkMode
                ? CustomGreenButton(
                    buttonText: "Ok",
                    onPressed: () {
                      Navigator.pop(context);
                    })
                : GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 58.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          gradient:
                              const LinearGradient(colors: [orange2, orange1])),
                      child: Center(
                        child: Text(
                          "Ok",
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                              color: whiteColor),
                        ),
                      ),
                    ),
                  ),
           
           
          ],
        );
      },
    );
  }
 void _showSuccesPopup(BuildContext context,String whatsappUrl,String smsUrl) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
          backgroundColor: isDarkMode ? lightBlackColor2 : whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon: Image.asset(
            isDarkMode
                ? "assets/images/success21.png"
                : "assets/images/success2.png",
            height: 180.h,
            width: 186.w,
          ),
          title: Text(
            "Send Invite",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? lightGreenColor : orange3),
          ),
          content: Text(
              textAlign: TextAlign.center,
              "Choose how you want to send the invite.",
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? whiteColor : blackColor2)),
          actions: [
            isDarkMode
                ? CustomGreenButton(
                    buttonText: "WhatsApp",
                    onPressed: () {
                      Navigator.pop(context);
                    })
                : GestureDetector(
                    onTap: () async{
                       Get.back(); // Close the dialog
      if (await canLaunch(whatsappUrl)) {
        await launch(whatsappUrl);
      } else {
        Get.snackbar("Error", "WhatsApp is not available.");
      }
                    },
                    child: Container(
                      height: 58.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          gradient:
                              const LinearGradient(colors: [orange2, orange1])),
                      child: Center(
                        child: Text(
                          "Whatsapp",
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
                buttonText: "SMS",
                onPressed: () async{
                   Get.back(); // Close the dialog
      if (await canLaunch(smsUrl)) {
        await launch(smsUrl);
      } else {
        Get.snackbar("Error", "SMS is not available.");
      }
                })
          ],
        );
      },
    );
  }

 
}
