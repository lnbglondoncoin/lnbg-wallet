import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';

class BuyCoinScreen extends StatelessWidget {
  final String coinCode;
  const BuyCoinScreen({super.key, required this.coinCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: "Buy $coinCode",
        iconPath: 'assets/icons/search.svg',
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 100.w,
                height: 45.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(color: orange3)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "USD",
                        style: GoogleFonts.urbanist(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: orange3),
                      ),
                      SvgPicture.asset("assets/icons/diamond.svg")
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
