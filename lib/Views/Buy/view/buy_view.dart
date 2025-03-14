import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/buy_coin.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';

class BuyView extends StatelessWidget {
   BuyView({super.key});
 final walletCreatingController=Get.find<WalletCreatingController>();
  @override
  Widget build(BuildContext context) {
         var theme = Theme.of(context);
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:  isDarkMode?lightBlackColor3:whiteColor,
      appBar: const CustomAppBar(
        title: "Buy",
        iconPath: 'assets/icons/search.svg',
      ),
      body: Obx((){
        return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: ListView.builder(
              itemCount: walletCreatingController.tokenData.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                 final token = walletCreatingController.tokenData[index];

                return Padding(
                  padding: EdgeInsets.only(
                      bottom: index ==walletCreatingController.tokenData.length-1 ? 50.h : 0),
                  child: GestureDetector(
                    onTap: () {
                     // Must umcomment when add sambol in model
                      Get.to(() => BuyCoinScreen(
                            // coinCode: token.sambol,
                            token: token,
                          ));
                    },
                    child: Container(
                      // height: 80.h,
                      width: double.infinity,
                      decoration:  BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: isDarkMode?lightBlackColor: lightBlack))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 45.h,
                              width: 35.w,
                              child: Center(
                                child: Image.network(
                                   token.logoUrl
                                  
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                             token.name,
                              style: GoogleFonts.urbanist(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color:isDarkMode?whiteColor: blackColor2),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                 "\$${token.balance.toStringAsFixed(2)} ${token.symbol}",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: isDarkMode?whiteColor: blackColor2),
                                ),
                                Text(
                                "\$${ token.balanceInUsd.toStringAsFixed(2)}",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w800,
                                      color:isDarkMode?greyColor: greyColor3),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
      })
      
         );
  }
}
