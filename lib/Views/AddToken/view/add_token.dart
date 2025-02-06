  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_svg/svg.dart';
  import 'package:get/get.dart';
  import 'package:get/get_core/src/get_main.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
  import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
  import 'package:lnbg_crypto_wallet_app/Views/AddToken/controller/add_token_controller.dart';
  import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
  import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';

  class AddTokenScreen extends StatelessWidget {
    const AddTokenScreen({super.key});

    @override
    Widget build(BuildContext context) {
      var theme = Theme.of(context);
      var textTheme = theme.textTheme;
      bool isDarkMode =
          theme.brightness == Brightness.dark; // Check if dark mode is active
          final controller=Get.put(AddTokenController());
      return Scaffold(
  backgroundColor: theme.scaffoldBackgroundColor,
  appBar: AppBar(
  leading:  GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SizedBox(
              height: 28.h,
              width: 28.w,
              child: Center(child: SvgPicture.asset("assets/icons/leading.svg")),
            ),
          ),
          title:     
              Obx(() {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          
                          color: controller.isAmountEmpty.value
                              ?isDarkMode?lightBlackColor2: lightWhiteColor
                              : lightGreenColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(
                            color: controller.isAmountEmpty.value
                                ? isDarkMode?lightBlackColor2:lightWhiteColor
                                : orange3,
                          ),
                        ),
                        child:  TextFormField(
                          
                          controller: controller.ammountController,
                          onChanged: (value) {
                            controller
                                .updateAmount(); // Call this method to update the reactive value
                          },
                          decoration: InputDecoration(
                            prefixIcon: SizedBox(
                              height: 16.h,
                              width: 16.w,
                              child: Center(child: SvgPicture.asset("assets/icons/search2.svg",colorFilter: 
                              ColorFilter.mode(controller.isAmountEmpty.value?grey2:orange3, BlendMode.srcIn),))),
                            border: InputBorder.none,
                            hintText: "Search Tokens",
                            hintStyle: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w400,
                              color: greyColor2,
                              fontSize: 18.sp,
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                          ),
                        
                        ),
                      );
                    }),
          
      actions: [
          
          Padding(
            padding:  EdgeInsets.only(right: 20.w),
            child: SvgPicture.asset("assets/icons/plusIcon.svg",colorFilter: ColorFilter.mode(isDarkMode?whiteColor:blackColor2, BlendMode.srcIn),),
          )
      ], 
    elevation: 1.0,         
  ),
  body: 
  Container(
    height: Get.height,
    width: double.infinity,
    child: Padding(
      padding:  EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: tokenIconList.length,
        itemBuilder: (context,index){
        return Padding(
          padding:  EdgeInsets.only(bottom: index==tokenIconList.length-1?80.h:0.h),
          child: Container(
            height: 70.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(
                color: lightBlack
              ))
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  SizedBox(
                                                          height: 45.h,
                                                          width: 35.w,
                                                          child: Center(
                                                            child: Image.asset(
                                                              tokenIconList[index],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 30.w,),
                                                        Text(
                                                              tokenList[index],
                                                              style: GoogleFonts.urbanist(
                                                                  fontSize: 20.sp,
                                                                  fontWeight:
                                                                      FontWeight.w700,
                                                                  color: isDarkMode
                                                                      ? whiteColor
                                                                      : blackColor2),
                                                            ),
                                                            Spacer(),
                                                           Obx(() => CustomSwitch(
                    isSwitched: controller.switchStates[index], // Now correctly passing RxBool
                  )),
                ],
              ),
            ), 
          ),
        );
      }),
    ),
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  floatingActionButton: Padding(
    padding:  EdgeInsets.symmetric(horizontal: 20.w),
    child: CustomButton(buttonText: "Ok", onPressed: (){
      
    }),
  ),
      );
    } 
  }