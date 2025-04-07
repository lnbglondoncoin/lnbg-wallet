import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_textfeild.dart';

class ImportNFTScreen extends StatelessWidget {
  const ImportNFTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: const CustomAppBar(title: "Import NFT", iconPath: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            children: [
              CustomTextField(
                  hintText: "0x7131CA84856767f3126a2C75468d48f8E696",
                  controller: TextEditingController(),
                  labelText: "Address"),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                  hintText: "Enter the Collectible ID",
                  controller: TextEditingController(),
                  labelText: "ID")
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: isDarkMode ? lightBlackColor3 : whiteColor,
            border: Border(
                top: BorderSide(
                    color: isDarkMode ? lightBlackColor : greyColor4))),
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Row(
            children: [
              Flexible(
                  child: CustomLightGreenButton(
                      buttonText: "Cancel", onPressed: () {})),
              SizedBox(
                width: 10.w,
              ),
              Flexible(
                  child: CustomButton(buttonText: "Import", onPressed: () {}))
            ],
          ),
        ),
      ),
    );
  }
}
