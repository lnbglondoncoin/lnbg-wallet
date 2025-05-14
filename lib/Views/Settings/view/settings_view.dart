import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Constants/theme_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Settings/controller/settings_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Settings/view/social_media_grid.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';

class SettingView extends StatelessWidget {
  final ThemeController themeController = Get.find();
  SettingView({
    super.key,
  });
  final controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active
    RxBool swictched = isDarkMode ? true.obs : false.obs;
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 20.w, top: 60.h, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      logo,
                      height: 28.h,
                      width: 28.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Settings".tr,
                      style: GoogleFonts.poppins(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? whiteColor : blackColor2),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: controller.settingIcons.length,
                    itemBuilder: (context, index) {
                      //final item = controller.settingIcons[index];
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: GestureDetector(
                              onTap: () {
                                controller.settingActions(index);
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Image.asset(
                                    controller.settingIcons[index],
                                    width: 56.w,
                                    height: 56.h),
                                title: Obx((){
                                  return Text(controller.settingLabels[index].toString().tr,
                                    style: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp,
                                        color: isDarkMode
                                            ? whiteColor
                                            : blackColor2));
                                }),
                                trailing: index == 2
                                    ? CustomSwitch(
                                        isSwitched: swictched,
                                        onChanged: () {
                                          themeController.toggleTheme();
                                        },
                                      )
                                    : SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/icons/arrowRight.svg",
                                            colorFilter: ColorFilter.mode(
                                                isDarkMode
                                                    ? whiteColor
                                                    : blackColor2,
                                                BlendMode.srcIn),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const CustomDivider()
                        ],
                      );
                    }),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Follow us:".tr,
                  style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? whiteColor : blackColor2),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SocialMediaGrid(),
                SizedBox(
                  height: 20.h,
                ),
              ],
            )),
      ),
    );
  }
}
