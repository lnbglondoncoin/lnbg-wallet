import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/controller/uy_coin_contrller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/select_currency_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/select_provider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class BuyCoinScreen extends StatelessWidget {
  final String coinCode;
  BuyCoinScreen({super.key, required this.coinCode});
  final CurrencyController controller = Get.put(CurrencyController());

  @override
  Widget build(BuildContext context) {
        var theme = Theme.of(context);
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
        backgroundColor:  isDarkMode?lightBlackColor3:whiteColor,
        appBar: CustomAppBar(
          title: "Buy $coinCode",
          iconPath: 'assets/icons/search.svg',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.h),
          child: Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => CurrencySelectionScreen());
                  },
                  child: Container(
                    width: 100.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        border: Border.all(color:isDarkMode?lightGreenColor: orange3)),
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
                                  color:isDarkMode?lightGreenColor: orange3),
                            );
                          }),
                          SvgPicture.asset("assets/icons/diamond.svg",colorFilter: ColorFilter.mode(isDarkMode?
                          lightGreenColor:orange3
                          , BlendMode.srcIn),)
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
  child:  Align(
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
              color:isDarkMode?lightGreenColor:  orange3,
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: GoogleFonts.urbanist(
            fontSize: 58.sp,
            fontWeight: FontWeight.w700,
            color:isDarkMode?lightGreenColor:  orange3,
          ),
          cursorColor:isDarkMode?lightGreenColor:  orange3,
          textAlign: TextAlign.center,
          onChanged: (value) {
            controller.amount.value = value.isEmpty ? "0" : value;
          },
        ),
      ),
    )
 
),

              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                return Text(
                  "~ ${controller.amount} ETH",
                  style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color:isDarkMode?greyColor: greyColor3),
                );
              }),
              SizedBox(
                height: 40.h,
              ),
              CustomDivider(),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SelectProviderScreen());
                },
                child: Container(
                  height: 80.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color:isDarkMode?lightBlackColor: lightBlack)),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset(
                          "assets/icons/binance.svg",
                          height: 44.h,
                          width: 44.w,
                        ),
                        title: Text(
                          "Binance Connect",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color:isDarkMode?whiteColor: blackColor2),
                        ),
                        trailing:
                            SvgPicture.asset("assets/icons/arrowRight.svg",colorFilter: 
                            ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn),),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: EdgeInsets.all(20.h),
            child: isDarkMode?CustomGreenButton(
                buttonText: "Continue",
                onPressed: () {
                  _showSuccesPopup(context);
                }):CustomButton(
                buttonText: "Continue",
                onPressed: () {
                  _showSuccesPopup(context);
                })));
  }

  void _showSuccesPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon: Image.asset(
            "assets/images/buySuccess.png",
            height: 180.h,
            width: 186.w,
          ),
          title: Text(
            "Successful Purchase!",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp, fontWeight: FontWeight.w700, color: orange3),
          ),
          content: Text(
              textAlign: TextAlign.center,
              "Purchase Success! Crypto has been added to your wallet.",
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: blackColor2)),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 58.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    gradient: const LinearGradient(colors: [orange2, orange1])),
                child: Center(
                  child: Text(
                    "View Details",
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: whiteColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomLightGreenButton(
                buttonText: "Cancel",
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }
}
