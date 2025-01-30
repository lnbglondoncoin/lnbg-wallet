import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_textfeild.dart';

class AddNewCardScreen extends StatelessWidget {
  const AddNewCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
        appBar: CustomAppBar(
        title: "Add New Card",
        iconPath: scanIcon,
        isSuffix: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(20.h),
          child: Column(
            children: [
              CustomTextField2(hintText: '7648 4737 4840 2799', controller: TextEditingController(), labelText: 'Card Number',),
              SizedBox(height: 25.h,),
                CustomTextField2(hintText: 'Andrew Ainsley', controller: TextEditingController(), labelText: 'Card Name',),
                   SizedBox(height: 25.h,),
                CustomTextField2(hintText: '7648 4737 4840 2799', controller: TextEditingController(), labelText: 'Expiration Date',),
                   SizedBox(height: 25.h,),
                CustomTextField2(hintText: '12/26/2025', controller: TextEditingController(), labelText: 'Expiration Date',
                isSuffix: true,
                suffixiconPath: "assets/icons/calendar.svg",),
                   SizedBox(height: 25.h,),
                CustomTextField2(hintText: '755', controller: TextEditingController(), labelText: '755CVV',isNumber: true,)
            ],
          ),
        ),
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:Padding(
        padding:  EdgeInsets.all(20.h),
        child: CustomButton(buttonText: "Continue", onPressed: (){
         
        }),
      ),
    );
  }
}