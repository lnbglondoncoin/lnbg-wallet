import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/GeneralSettings/controller/general_settings_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Security&Privacy/controller/security_and_privacy_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/reuseable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenralSettingsView extends StatelessWidget {
  final controller = Get.put(GeneralSettingsController());
    final SecurityAndPrivacyController securityController =
      Get.find<SecurityAndPrivacyController>();
  GenralSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar:  CustomAppBar(
        iconPath: '',
        title: 'Change Language'.tr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // _buildSectionTitle('Currency Conversion', context),
              // SizedBox(height: 10.h),
              // Text('Updated Sat Dec 24, 2022 10:11:27 GMT+0700 (US Time)',
              //     style: GoogleFonts.urbanist(
              //         fontSize: 14.sp,
              //         color: isDarkMode ? greyColor : greyColor3,
              //         fontWeight: FontWeight.w500)),
              // SizedBox(height: 10.h),
              // ReusableDropdown(
              //   items: const [
              //     'USD - United States Dollar',
              //     'EUR - Euro',
              //     'JPY - Japanese Yen'
              //   ],
              //   selectedValue: controller.selectedCurrency,
              // ),
              // SizedBox(height: 40.h),
              // _buildSectionTitle('Primary Currency', context),
              // SizedBox(height: 10.h),
              // Text(
              //   'Select native to prioritize displaying values in the native currency of the chain (e.g. ETH). Select Fiat to prioritize displaying values in your selected fiat currency.  ',
              //   style: GoogleFonts.urbanist(
              //       fontSize: 14.sp,
              //       color: isDarkMode ? greyColor : greyColor3),
              // ),
              // SizedBox(height: 10.h),
              // SizedBox(
              //   height: 22.h,
              //   child: ListView.builder(
              //       itemCount: 2,
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       physics: const NeverScrollableScrollPhysics(),
              //       itemBuilder: (context, index) {
              //         return Padding(
              //           padding: EdgeInsets.only(right: 20.w),
              //           child: Row(
              //             children: [
              //               GestureDetector(
              //                 onTap: () {
              //                   controller.changeCurrencyType(index);
              //                 },
              //                 child: Container(
              //                   height: 20.h,
              //                   width: 20.w,
              //                   decoration: BoxDecoration(
              //                       shape: BoxShape.circle,
              //                       color: isDarkMode
              //                           ? lightBlackColor3
              //                           : whiteColor,
              //                       border: Border.all(
              //                           color: isDarkMode
              //                               ? lightGreenColor
              //                               : orange3,
              //                           width: 2)),
              //                   child: Center(child: Obx(() {
              //                     return Container(
              //                       height: 10.h,
              //                       width: 10.w,
              //                       decoration: BoxDecoration(
              //                           shape: BoxShape.circle,
              //                           color: index ==
              //                                   controller
              //                                       .selectedCurrencyType.value
              //                               ? isDarkMode
              //                                   ? lightGreenColor
              //                                   : orange3
              //                               : isDarkMode
              //                                   ? lightBlackColor3
              //                                   : whiteColor),
              //                     );
              //                   })),
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: 10.w,
              //               ),
              //               Text(
              //                 index == 0 ? "Native" : "Fiat",
              //                 style: GoogleFonts.urbanist(
              //                     fontSize: 18.sp,
              //                     fontWeight: FontWeight.w800,
              //                     color: isDarkMode ? whiteColor : blackColor2),
              //               ),
              //             ],
              //           ),
              //         );
              //       }),
              // ),
            
             SizedBox(height: 40.h),
              _buildSectionTitle('Current Language'.tr, context),
              SizedBox(height: 10.h),
              Text(
                  'Translate the application to a different supported language.'.tr,
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      color: isDarkMode ? greyColor : greyColor3)),
              SizedBox(height: 10.h),
              ReusableDropdown(
                items: controller.items,
                selectedValue: controller.selectedLanguage,
                onChanged: (value)  {
                  var box=GetStorage();
                  if (value == 'English - US'.tr) {
                    controller.items.value=['English - US', 'Spanish - ES', 'French - FR'];
                    controller.selectedLanguage.value = 'English - US';
                    Get.updateLocale(Locale('en', 'US'));
                     box.write('selected_language', 'en_US');
                  } else if (value == 'Spanish - ES'.tr) {
                     controller.items.value=["Inglés - EE.UU.", "Español - ES", "Francés - FR"];
                    controller.selectedLanguage.value = 'Español - ES';
                    Get.updateLocale(Locale('es', 'ES'));
                     box.write('selected_language', 'es_ES');
                  } else {
                     controller.items.value=['Anglais - US', 'Espagnol - ES', 'Français - FR'];
                    controller.selectedLanguage.value = 'Français - FR';
                    Get.updateLocale(Locale('fr', 'FR'));
                  box.write('selected_language', 'fr_FR');
                  }
                 // securityController.loadSelectedTime();
                },
              ),
              // SizedBox(height: 40.h),
              // _buildSectionTitle('Search Engine', context),
              // Text(
              //     'Change the default search engine used when entering search terms in the URL bar.',
              //     style: GoogleFonts.urbanist(
              //         fontSize: 14.sp,
              //         color: isDarkMode ? greyColor : greyColor3)),
              // SizedBox(height: 10.h),
              // ReusableDropdown(
              //   items: const ['Google', 'Bing', 'DuckDuckGo'],
              //   selectedValue: controller.selectedSearchEngine,
              // ),
              // SizedBox(
              //   height: 40.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Hide Tokens Without Balance",
              //       style: GoogleFonts.urbanist(
              //           fontSize: 20.sp,
              //           fontWeight: FontWeight.w700,
              //           color: isDarkMode ? whiteColor : blackColor2),
              //     ),
              //     CustomSwitch(isSwitched: controller.isSwiched),
              //   ],
              // ),
              // SizedBox(
              //   height: 100.h,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        title,
        style: GoogleFonts.urbanist(
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            color: isDarkMode ? whiteColor : blackColor2),
      ),
    );
  }
}
