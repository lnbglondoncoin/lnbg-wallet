import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/add_new_card.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';

class SelectProviderScreen extends StatelessWidget {
  const SelectProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
        appBar: CustomAppBar(
        title: "Providers",
        iconPath: 'assets/icons/search.svg',
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.builder(
          itemCount: providerIcons.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index){
          return  Padding(
            padding:  EdgeInsets.only(bottom: index==providerIcons.length-1?60.h:0),
            child: Container(
              height: 75.h,
              decoration: BoxDecoration(
                
                border: Border(bottom: BorderSide(
                  color: lightBlack
                ))
              ),
              child: Center(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(providerIcons[index],height: 44.h,
                  width: 44.w,),
                title: Text(providersTitles[index],
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: blackColor2
                ),),
                trailing: Text(providersprice[index],
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: blackColor2
                ),),
                ),
              ),
            ),
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding:  EdgeInsets.all(20.h),
        child: CustomLightGreenButton(buttonText: "Add Credit or Debit Card", onPressed: () { 
          Get.to(()=>AddNewCardScreen());
         },),
      ),
    );
  }
}