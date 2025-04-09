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
import 'package:lnbg_crypto_wallet_app/Widgets/custom_loading_spinner.dart';
import 'package:shimmer/shimmer.dart';

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
      body: 
      Obx((){
        return controller.isLoading.value
      ? _buildShimmerLayout(isDarkMode)
      : SingleChildScrollView(
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
                                controller.selectedNetworkSpeed.value=="Slow"?
                             "${controller.networkFeeSlowCrypto.value} ${token.symbol} (\$${ controller.networkFeeSlowUsd.value.toString()} USD)":
                               controller.selectedNetworkSpeed.value=="Moderate"?
                                 "${controller.networkFeeModeratecrypto.value} ${token.symbol} (\$${ controller.networkFeeModerateUsd.value.toString()} USD)":
                                "${controller.networkFeeFastcrypto.value} ${token.symbol} (\$${ controller.networkFeeFastUsd.value.toString()} USD)",
                               
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
                                
                                controller.selectedNetworkSpeed.value=="Slow"?
                                  "${controller.totalFeeSlowCrypto.value} ${token.symbol} (\$${ controller.totalFeeSlowUsd.value.toString()} USD)":
                                   controller.selectedNetworkSpeed.value=="Moderate"?
                                     "${controller.totalFeeModerateCrypto.value} ${token.symbol} (\$${ controller.totalFeeModerateUsd.value.toString()} USD)":
                                      "${controller.totalFeeFastCrypto.value} ${token.symbol} (\$${ controller.totalFeeFastUsd.value.toString()} USD)",
                                    
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
      );
      }),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(25.h),
        child: Obx((){
          return controller.isLoading.value?
        const  LoadingSpinner()
          :isDarkMode? CustomGreenButton(
            buttonText: "Send",
            onPressed: () async{
           await controller. sendCoin(
            context: context,
  recipientAddress: controller.addressController.text,
  amountToSend: controller.ammountIncrypto.value,
  privateKey: controller.walletCreatingCotroller.privateKey!,
);
               
            }): CustomButton(
            buttonText: "Send",
            onPressed: ()async {
             await controller. sendCoin(
               context: context,
  recipientAddress: controller.addressController.text,
  amountToSend: controller.ammountIncrypto.value,
  privateKey: controller.walletCreatingCotroller.privateKey!,
);
                
            });
        })
      ),
    );
  }
Widget _buildShimmerLayout(bool isDarkMode) {
  return Shimmer.fromColors(
    baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
    highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Shimmer
              Center(
                child: Container(
                  width: 250.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              // USD Amount Shimmer
              Center(
                child: Container(
                   width: 150.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              // Divider Shimmer
              Container(
                height: 1.h,
                color: Colors.white,
              ),
              SizedBox(height: 20.h),

              // From Section Shimmer
              Container(
                width: 60.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                 height: 18.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 20.h),

              // To Section Shimmer
              Container(
                width: 40.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 18.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
 SizedBox(width: 10.w),
                  Container(
                    width: 24.w,
                    height: 24.h,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                height: 1.h,
                color: Colors.white,
              ),
              SizedBox(height: 10.h),

              // Network Fee Section Shimmer
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                   SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 18.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 24.w,
                    height: 24.h,
                    color: Colors.white,
                  ),
                ],
              ),
              Container(
                height: 1.h,
                color: Colors.white,
              ),
              SizedBox(height: 10.h),

              // Max Total Section Shimmer
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                    width: 80.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 18.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        // Bottom Divider Shimmer
        Container(
          height: 1.h,
          color: Colors.white,
        ),
         SizedBox(height: 200.h),
      ],
    ),
  );
}
}
