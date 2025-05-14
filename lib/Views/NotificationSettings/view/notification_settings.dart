import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/NotificationSettings/controller/notification_setting_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';

class NotificationSettingsView extends StatelessWidget {
  NotificationSettingsView({super.key});
  final controller = Get.put(NotificationSettingsController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar:  CustomAppBar(title: "Notifications".tr, iconPath: ""),
      body: Padding(
          padding: EdgeInsets.all(20.h),
          child: ListView.builder(
              itemCount: controller.tabs.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.tabs[index].tr,
                        style: GoogleFonts.urbanist(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: isDarkMode ? whiteColor : blackColor2),
                      ),
                      CustomSwitch(
                        isSwitched: controller.switchStates[index],
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
