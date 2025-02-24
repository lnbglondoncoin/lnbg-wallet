import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/controller/send_controllr.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/edit_network_screen.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class ConfirmSendCoinScreen extends StatelessWidget {
  final String ammount;
  final String address;
  final String coinCode;
  ConfirmSendCoinScreen(
      {super.key,
      required this.ammount,
      required this.address,
      required this.coinCode});
  final controller = Get.put(SendController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode?lightBlackColor3:whiteColor,
      appBar: const CustomAppBar(
        title: "Confirm",
        iconPath: 'assets/icons/search.svg',
        isSuffix: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "$ammount $coinCode",
                        style: GoogleFonts.urbanist(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.w700,
                            color:isDarkMode?lightGreenColor: orange3),
                      ),
                    ),
                    Center(
                      child: Text(
                        "\$2,107.11 USD",
                        style: GoogleFonts.urbanist(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color:isDarkMode?greyColor: greyColor3),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    const CustomDivider(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "From",
                      style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color:isDarkMode?whiteColor: blackColor2),
                    ),
                    Text(
                      address==""?"Adress":"fvjhgv",
                      style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode?whiteColor: blackColor2),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "To",
                      style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color:isDarkMode?whiteColor: blackColor2),
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: TextFormField(
                          controller: controller.recipientAddressController,
                          enabled: controller.recipientAddressController.text == "" ||
                                  controller.isEditClicked.value == true
                              ? true
                              : false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter address to send",
                            hintStyle: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode?whiteColor: greyColor2),
                          ),
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color:isDarkMode?whiteColor: blackColor2),
                        )),
                        GestureDetector(
                            onTap: () {
                              controller.isEditClicked.value == true;
                            },
                            child: SvgPicture.asset("assets/icons/Edit.svg",colorFilter: ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn),))
                      ],
                    ),
                    const CustomDivider(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Network Fee",
                          style: GoogleFonts.urbanist(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color:isDarkMode?whiteColor: blackColor2),
                        ),
                        const Spacer(),
                        Flexible(
                            child: TextFormField(
                          controller: controller.recipientAddressController,
                          enabled: controller.recipientAddressController.text == "" ||
                                  controller.isEditClicked.value == true
                              ? true
                              : false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "0.02 ETH (\$26.35 USD)",
                            hintStyle: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color:isDarkMode?whiteColor: blackColor2),
                          ),
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color:isDarkMode?whiteColor: blackColor2),
                        )),
                        GestureDetector(
                            onTap: () {
                              Get.to(() => EditNetworkScreen(
                                    coinCode: coinCode,
                                  ));
                            },
                            child: SvgPicture.asset("assets/icons/Edit.svg",colorFilter: ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn)))
                      ],
                    ),
                    const CustomDivider(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Max Total",
                          style: GoogleFonts.urbanist(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color:isDarkMode?whiteColor: blackColor2),
                        ),
                        const Spacer(),
                        Flexible(
                            child: TextFormField(
                          controller: controller.recipientAddressController,
                          enabled: controller.recipientAddressController.text == "" ||
                                  controller.isEditClicked.value == true
                              ? true
                              : false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "0.02 ETH (\$26.35 USD)",
                            hintStyle: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color:isDarkMode?whiteColor: blackColor2),
                          ),
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: blackColor2),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
             Spacer(),
               CustomDivider(),
               SizedBox(height: 200.h,)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(25.h),
        child:isDarkMode? CustomGreenButton(
            buttonText: "Send",
            onPressed: () {
               _showFailPopup(context);
            }): CustomButton(
            buttonText: "Send",
            onPressed: () {
                _showSuccesPopup(context);
            }),
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
           isDarkMode? "assets/images/success21.png": "assets/images/success2.png",
            height: 180.h,
            width: 186.w,
          ),
          title: Text(
            "Successful Sent!",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp, fontWeight: FontWeight.w700, color: isDarkMode?lightGreenColor:orange3),
          ),
          content: Text(
              textAlign: TextAlign.center,
              "Your crypto was sent successfully. You can view transaction below.",
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

  void _showFailPopup(BuildContext context) {
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
           isDarkMode? "assets/images/fail2.png": "assets/images/fail.png",
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
              "Please check your internet connection, and then try again.",
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                   color: isDarkMode?whiteColor: blackColor2)),
          actions: [
            isDarkMode?CustomGreenButton(buttonText: "Try Again", onPressed: (){
                Navigator.pop(context);
            }):GestureDetector(
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
                    "Try Again",
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
