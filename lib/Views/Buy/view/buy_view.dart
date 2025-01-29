import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/buy_coin.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';

class BuyView extends StatelessWidget {
  const BuyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(
        title: "Buy",
        iconPath: 'assets/icons/search.svg',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: ListView.builder(
              itemCount: coinIconList.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                String coinCode = coinPrice[index];
                List<String> parts = coinCode.split(' ');
                String currencyCode = parts.length > 1
                    ? parts[1]
                    : ''; // Getting the part after the space (BTC)

                return Padding(
                  padding: EdgeInsets.only(
                      bottom: index == coinList.length - 1 ? 50.h : 0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => BuyCoinScreen(
                            coinCode: currencyCode,
                          ));
                    },
                    child: Container(
                      // height: 80.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: lightBlack))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 45.h,
                              width: 35.w,
                              child: Center(
                                child: Image.asset(
                                  coinIconList[index],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                              coinList[index],
                              style: GoogleFonts.urbanist(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: blackColor2),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  coinPrice[index],
                                  style: GoogleFonts.urbanist(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: blackColor2),
                                ),
                                Text(
                                  coinndolorPrice[index],
                                  style: GoogleFonts.urbanist(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w800,
                                      color: greyColor3),
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
      ),
    );
  }
}
