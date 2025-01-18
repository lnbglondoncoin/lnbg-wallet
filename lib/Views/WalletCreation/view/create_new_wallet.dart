import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/wallet_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/tep_widget.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_textfeild.dart';

class CreateNewWallet extends StatelessWidget {
  CreateNewWallet({super.key});
  final StepController controller = Get.put(StepController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: whiteColor,
        shadowColor: whiteColor,
        foregroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: GestureDetector(
            onTap: (){
             Get.back();
            },
            child: SizedBox(
              height: 28.h,
              width: 28.w,
              child: Center(child: SvgPicture.asset(arrowLeft)),
            ),
          ),
        ),
        title: SizedBox(
          width: Get.width / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => buildStep(0)), // Wrap individual widgets
              Obx(() => buildLine(1)),
              Obx(() => buildStep(1)),
              Obx(() => buildLine(2)),
              Obx(() => buildStep(2)),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Expanded(
          child: Form(
              key: controller.passwordKey,
            child: Column(
              children: [
                Padding(
                 
                  padding: EdgeInsets.only(top: 25.h, left: 18.w,right:18.w,bottom: 20.h),
                  child: Column(
                    children: [
                    CustomDivider(),
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        "Create Password",
                        style: GoogleFonts.urbanist(
                            fontSize: 32.sp, fontWeight: FontWeight.w700, color: orange3),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "This password will unlock your LNBG Wallet wallet only on this device.",
                        style: GoogleFonts.urbanist(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: darkGreyColor),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomTextField(
                          hintText: "Password",
                          controller: controller.passController,
                          labelText: "New Password",
                          suffixIcoPath: eyeIcon,
                          prefixIconPath: lockIcon,
                         validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value.length<8)
                     {
                    return "Must be at least 8 characters";
                  }
                  return null;
                                  },
                          ),
                           SizedBox(
                        height: 30.h,
                      ),
                      CustomTextField(
                          hintText: "Password",
                          controller: controller.confirmPasswordController,
                          labelText: "Confirm New Password",
                          suffixIcoPath: eyeIcon,
                          prefixIconPath: lockIcon,
                         validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm Password cannot be empty";
                  } else if (value!=controller.passController.text)
                     {
                    return "Password must be match";
                  }
                  return null;
                                  },
                          ),
                          SizedBox(height: 35.h,),
                     CustomDivider(),
                          SizedBox(height: 35.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sign in with Face ID?",style: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color: blackColor2
                              ),),
                             CustomSwitch(isSwitched: controller.isSwitched1),
                            ],
                          ),
                          SizedBox(height: 30.h,),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sign in with Biometrics?",style: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color: blackColor2
                              ),),
                                CustomSwitch(isSwitched: controller.isSwitched2),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          CustomDivider(),
                          SizedBox(height: 20.h,),
                           Obx(
                      () => Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                  GestureDetector(
                    onTap: () {
                      controller.toggleCheckbox(!controller.isChecked.value);
                    },
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: orange3, width: 2),
                        borderRadius: BorderRadius.circular(5),
                        color: controller.isChecked.value?orange3:whiteColor
                      ),
                      child: controller.isChecked.value
                          ? Icon(Icons.check, size: 12.h, color: whiteColor)
                          : null,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "I understand that LNBG cannot recover this password for me. ",
                        style: GoogleFonts.urbanist(color: blackColor2, fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        height: 1.1.h),
                        children: [
                          TextSpan(
                            text: "Learn more",
                            style: GoogleFonts.urbanist(color: orange3, fontSize: 18.sp,
                        fontWeight: FontWeight.w800, height: 1.1.h),
                            // Launch URL or action when clicked
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Example of opening a URL
                                print("Learn more clicked!");
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                                  ],
                      ),
                    ),
                    // SizedBox(height: 1000.h,)
                   
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color:greyColor4 ,
                ),
                 SizedBox(height: 200.h,)
              ],
            ),
        
          ),
        ),
      ),
 floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
 floatingActionButton: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 8.h),
          child: CustomButton(buttonText: "Create Password", onPressed: (){
           controller.isChecked.value? controller.createPassword():Get.snackbar(
            backgroundColor: orange3,
          snackPosition: SnackPosition.TOP,
            "Attention", "Please accept terms and conditions");
          }
          
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
            ? LinearGradient(
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
              ? LinearGradient(
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
