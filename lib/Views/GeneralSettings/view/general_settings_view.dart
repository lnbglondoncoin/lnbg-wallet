import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/GeneralSettings/controller/general_settings_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/reuseable_dropdown.dart';




class GenralSettingsView extends StatelessWidget {
  final controller = Get.put(GeneralSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Currency Settings',
            style: GoogleFonts.urbanist(
                fontSize: 20.sp, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Currency Conversion'),
            Text('Updated Sat Dec 24, 2022 10:18:27 GMT+0700 (US Time)',
                style: GoogleFonts.urbanist(fontSize: 14.sp, color: Colors.grey)),
            SizedBox(height: 10.h),
            ReusableDropdown(
              items: ['USD - United States Dollar', 'EUR - Euro', 'JPY - Japanese Yen'],
              selectedValue: controller.selectedCurrency,
            ),
            SizedBox(height: 20.h),

            _buildSectionTitle('Primary Currency'),
            Text(
              'Select native to prioritize displaying values in the native currency of the chain e.g. ETH1.',
              style: GoogleFonts.urbanist(fontSize: 14.sp, color: Colors.grey),
            ),
            SizedBox(height: 10.h),
            ReusableDropdown(
              items: ['Native', 'Fiat'],
              selectedValue: controller.selectedCurrencyType,
            ),
            SizedBox(height: 20.h),

            _buildSectionTitle('Current Language'),
            Text('Translate the application to a different supported language.',
                style: GoogleFonts.urbanist(fontSize: 14.sp, color: Colors.grey)),
            SizedBox(height: 10.h),
            ReusableDropdown(
              items: ['English - US', 'Spanish - ES', 'French - FR'],
              selectedValue: controller.selectedLanguage,
            ),
            SizedBox(height: 20.h),

            _buildSectionTitle('Search Engine'),
            Text('Change the default search engine used when entering search terms.',
                style: GoogleFonts.urbanist(fontSize: 14.sp, color: Colors.grey)),
            SizedBox(height: 10.h),
            ReusableDropdown(
              items: ['Google', 'Bing', 'DuckDuckGo'],
              selectedValue: controller.selectedSearchEngine,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        title,
        style: GoogleFonts.urbanist(fontSize: 18.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}
