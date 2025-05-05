import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/controller/buy_coin_contrller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/select_currency_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/select_provider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_loading_spinner.dart';

class BuyCoinScreen extends StatelessWidget {
  final TokenData token;
  BuyCoinScreen({super.key, required this.token});
  final CurrencyController controller = Get.put(CurrencyController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
        backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
        appBar: CustomAppBar(
          title: "Buy ${token.symbol}",
          iconPath: 'assets/icons/search.svg',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.h),
          child: Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.currencySelectionScreen);
                   
                  },
                  child: Container(
                    width: 100.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        border: Border.all(
                            color: isDarkMode ? lightGreenColor : orange3)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(() {
                            return Text(
                              controller.selectedCurrency.value,
                              style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      isDarkMode ? lightGreenColor : orange3),
                            );
                          }),
                          SvgPicture.asset(
                            "assets/icons/diamond.svg",
                            colorFilter: ColorFilter.mode(
                                isDarkMode ? lightGreenColor : orange3,
                                BlendMode.srcIn),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Center(
                  child: Align(
                alignment: Alignment.center,
                child: IntrinsicWidth(
                  child: TextFormField(
                    controller: controller.amountController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "\$0",
                      hintStyle: GoogleFonts.urbanist(
                        fontSize: 58.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? lightGreenColor : orange3,
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    style: GoogleFonts.urbanist(
                      fontSize: 58.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? lightGreenColor : orange3,
                    ),
                    cursorColor: isDarkMode ? lightGreenColor : orange3,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      controller.updateAmount(value, token.priceInUsd);
                    },
                  ),
                ),
              )),
              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                return Text(
                  "~ ${controller.cryptoAmount.value.toStringAsFixed(6)} ${token.symbol}",
                  style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? greyColor : greyColor3),
                );
              }),
              SizedBox(
                height: 40.h,
              ),
              const CustomDivider(),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                 // Get.to(() => SelectProviderScreen());
                },
                child: Container(
                  height: 80.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                          color: isDarkMode ? lightBlackColor : lightBlack)),
                  child: Center(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Obx(() {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: SvgPicture.asset(
                              controller.providerImage.value == ""
                                  ? isDarkMode
                                      ? "assets/icons/moonDark.svg":
                                      "assets/icons/moon.svg"
                                  : controller.providerImage.value,
                              height: 44.h,
                              width: 44.w,
                            ),
                            title: Text(
                              controller.selectedProvider.value,
                              style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: isDarkMode ? whiteColor : blackColor2),
                            ),
                            trailing: SvgPicture.asset(
                              "assets/icons/arrowRight.svg",
                              colorFilter: ColorFilter.mode(
                                  isDarkMode ? lightGreenColor : orange3,
                                  BlendMode.srcIn),
                            ),
                          );
                        })),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: EdgeInsets.all(20.h),
            child: Obx(() {
              return controller.isLoading.value
                  ? const LoadingSpinner()
                  : isDarkMode
                      ? CustomGreenButton(
                          buttonText: "Continue",
                          onPressed: () async {
                            if(controller.amountController.text==""||controller.amountController.text=="0"){
                              Get.snackbar("Empty Ammount", "Amount cannot be zero");

                            }
                           else{
                             if (controller.selectedProvider.value ==
                                "MoonPay") {
                              await controller.buyCrypto(token.symbol);
                            }
                           }
                         
                          })
                      : CustomButton(
                          buttonText: "Continue",
                          onPressed: () async {
                            if(controller.amountController.text==""||controller.amountController.text=="0"){
                              Get.snackbar("Empty Ammount", "Amount cannot be zero");
                            }
                            else{
                             if (controller.selectedProvider.value ==
                                "MoonPay") {
                              await controller.buyCrypto(token.symbol);
                            }
                           }
                          });
            })));
  }
}
