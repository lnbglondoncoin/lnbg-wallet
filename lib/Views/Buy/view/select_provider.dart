import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/controller/buy_coin_contrller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/add_new_card.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';

class SelectProviderScreen extends StatelessWidget {
  SelectProviderScreen({super.key});
  final CurrencyController controller = Get.put(CurrencyController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: const CustomAppBar(
        title: "Providers",
        iconPath: 'assets/icons/search.svg',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.builder(
            itemCount: providerIconsDark.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: index == providerIconsDark.length - 1 ? 60.h : 0),
                child: GestureDetector(
                  onTap: () {
                    controller.selectedProvider.value = providersTitles[index];
                    controller.providerImage.value = isDarkMode
                        ? providerIconsDark[index]
                        : providerIconLight[index];
                    Get.back();
                  },
                  child: Container(
                    height: 75.h,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: isDarkMode
                                    ? lightBlackColor
                                    : lightBlack))),
                    child: Center(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset(
                          isDarkMode
                              ? providerIconsDark[index]
                              : providerIconLight[index],
                          height: 44.h,
                          width: 44.w,
                        ),
                        title: Text(
                          providersTitles[index],
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: isDarkMode ? whiteColor : blackColor2),
                        ),
                        trailing: Text(
                          providersprice[index],
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: isDarkMode ? whiteColor : blackColor2),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(20.h),
        child: CustomLightGreenButton(
          buttonText: "Add Credit or Debit Card",
          onPressed: () {
            Get.to(() => const AddNewCardScreen());
          },
        ),
      ),
    );
  }
}
