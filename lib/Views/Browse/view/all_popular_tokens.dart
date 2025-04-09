import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/view/clear_history_bottomsheet.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class AllPopularTokens extends StatelessWidget {
  const AllPopularTokens({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active
          final walletCreatingController = Get.find<WalletCreatingController>();
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: CustomAppBar(
        title: "Popular Tokens",
        iconPath: "assets/icons/delete.svg",
      
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: walletCreatingController.hundredTokenData.length,
            itemBuilder: (context, index) {
              final item = walletCreatingController.hundredTokenData[index];
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading:
                        Image.network(item.logoUrl, width: 48.w, height: 48.h),
                    title: Text(item.name,
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                            color: isDarkMode ? whiteColor : blackColor2)),
                    subtitle: Text(
                      "Description",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                          color: isDarkMode ? greyColor : greyColor3),
                    ),
                    onTap: () {
                      // Handle tap if needed
                    },
                  ),
                  Visibility(
                      visible: index != walletCreatingController.hundredTokenData.length - 1,
                      child: CustomDivider())
                ],
              );
            }),
      ),
    );
  }

 
}
