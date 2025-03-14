import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/controller/send_controllr.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/edit_network_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class ConfirmSendCoinScreen extends StatelessWidget {
  // final String ammount;
  final String address;
  final TokenData token;
  ConfirmSendCoinScreen(
      {super.key,
      // required this.ammount,
      required this.address,
      required this.token});
  final controller = Get.put(SendController());
   final walletCreatingCotroller=Get.find<WalletCreatingController>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode?lightBlackColor3:whiteColor,
      appBar: const CustomAppBar(
        title: "Confirm",
        iconPath: 'assets/icons/search.svg',
        isSuffix: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "${controller.ammountIncrypto.value.toStringAsFixed(8)} ${token.symbol}",
                        style: GoogleFonts.urbanist(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.w700,
                            color:isDarkMode?lightGreenColor: orange3),
                      ),
                    ),
                    Center(
                      child: Text(
                         "\$${  controller.ammountInUSD.value.toStringAsFixed(10)} USD",
                        style: GoogleFonts.urbanist(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color:isDarkMode?greyColor: greyColor3),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    const CustomDivider(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "From",
                      style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color:isDarkMode?whiteColor: blackColor2),
                    ),
                    Text(
                      walletCreatingCotroller.wallwtAddress.value,
                      style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode?whiteColor: blackColor2),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "To",
                      style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color:isDarkMode?whiteColor: blackColor2),
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: TextFormField(
                          controller: controller.recipientAddressController,
                          enabled: controller.recipientAddressController.text == "" ||controller.recipientAddressController.text.isEmpty||
                                  controller.isEditClicked.value == true
                              ? true
                              : false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: address==""?"Enter address to send":address,
                            hintStyle: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode?whiteColor: greyColor2),
                          ),
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color:isDarkMode?whiteColor: blackColor2),
                        )),
                        GestureDetector(
                            onTap: () {
                              controller.isEditClicked.value == true;
                            },
                            child: SvgPicture.asset("assets/icons/Edit.svg",colorFilter: ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn),))
                      ],
                    ),
                    const CustomDivider(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Network Fee",
                          style: GoogleFonts.urbanist(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? whiteColor : blackColor2,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child:Obx((){
                              return  Text(
                              controller.selectedNetworkSpeed.value == "Slow"
                                  ? "${controller.networkFee.value} ${token.symbol} (\$${controller.networkFeeUsd.value} USD)"
                                  : controller.selectedNetworkSpeed.value == "Moderate"
                                      ? "${controller.moderateNetworkFee.value} ${token.symbol} (\$${controller.moderateNetworkFeeUsd.value} USD)"
                                      : "${controller.fastNetworkFee.value} ${token.symbol} (\$${controller.fastNetworkFeeUSD.value} USD)",
                              style: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color: isDarkMode ? whiteColor : blackColor2,
                              ),
                              softWrap: true,
                              textAlign: TextAlign.right,
                            );
                            })
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => EditNetworkScreen(token: token));
                          },
                          child: SvgPicture.asset(
                            "assets/icons/Edit.svg",
                            colorFilter: ColorFilter.mode(
                              isDarkMode ? lightGreenColor : orange3,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const CustomDivider(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Max Total",
                          style: GoogleFonts.urbanist(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? whiteColor : blackColor2,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Obx(() {
                            return Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                controller.selectedNetworkSpeed.value == "Slow"
                                    ? "${controller.totalAmount.value} ${token.symbol} (\$${controller.totalAmountUsd.value} USD)"
                                    : controller.selectedNetworkSpeed.value == "Moderate"
                                        ? "${controller.totalAmountModerate.value} ${token.symbol} (\$${controller.totalAmountModerateUsd.value} USD)"
                                        : "${controller.totalAmountFast.value} ${token.symbol} (\$${controller.totalAmountUsdFast} USD)",
                                style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: isDarkMode ? whiteColor : blackColor2,
                                ),
                                softWrap: true,
                                textAlign: TextAlign.right,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
             Spacer(),
               CustomDivider(),
               SizedBox(height: 200.h,)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(25.h),
        child: Obx((){
          return controller.isLoading.value?CircularProgressIndicator(
            color: orange3,
          ):isDarkMode? CustomGreenButton(
            buttonText: "Send",
            onPressed: () async{
              await controller.sendCrypto(context);
               
            }): CustomButton(
            buttonText: "Send",
            onPressed: ()async {
                await controller.sendCrypto(context);
                
            });
        })
      ),
    );
  }


}
