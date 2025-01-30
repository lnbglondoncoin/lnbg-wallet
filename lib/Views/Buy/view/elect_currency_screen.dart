import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/controller/uy_coin_contrller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';



class CurrencySelectionScreen extends StatelessWidget {
  final CurrencyController controller = Get.put(CurrencyController());

  final List<Map<String, String>> popularCurrencies = [
    {'code': 'USD', 'name': 'US Dollar'},
    {'code': 'GBP', 'name': 'British Pound'},
    {'code': 'EUR', 'name': 'Euro'},
    {'code': 'AUD', 'name': 'Australian Dollar'},
    {'code': 'RUB', 'name': 'Russian Ruble'},
  ];

  final List<Map<String, String>> allCurrencies = [
    {'code': 'BGN', 'name': 'Bulgarian Lev'},
    {'code': 'BRL', 'name': 'Brazilian Real'},
    {'code': 'CAD', 'name': 'Canadian Dollar'},
    {'code': 'CHF', 'name': 'Swiss Franc'},
    {'code': 'COP', 'name': 'Colombian Peso'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
      backgroundColor: whiteColor,
      shadowColor: whiteColor,
      foregroundColor: whiteColor,
      surfaceTintColor: whiteColor,
        automaticallyImplyLeading: false,
        title: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Icon(Icons.close, size: 20.sp,
                          color: blackColor2,),
              ),
              SizedBox(width: 10.w,),
              Text('Currency', style: GoogleFonts.urbanist(fontSize: 24.sp, fontWeight: FontWeight.w700,
              color: blackColor2)),
            ],
          ),
        ),
       
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Popular', style: GoogleFonts.urbanist(fontSize: 18.sp, fontWeight: FontWeight.w800,
            color: darkGreyColor)),
            SizedBox(height: 20.h),
            SizedBox(
             // height: 500.h,
              width: double.infinity,
              child: _buildCurrencyList(popularCurrencies)),
            CustomDivider(),
             SizedBox(height: 20.h),
            Text('All Currency', style:  GoogleFonts.urbanist(fontSize: 18.sp, fontWeight: FontWeight.w800,
            color: darkGreyColor)),
            SizedBox(height: 20.h),
            Expanded(child: _buildCurrencyList(allCurrencies)),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyList(List<Map<String, String>> currencies) {
    return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemCount: currencies.length,
          itemBuilder: (context, index) {
            var currency = currencies[index];
            bool isSelected = controller.selectedCurrency.value == currency['code'];
            return Padding(
              padding:  EdgeInsets.only(bottom: 20.h),
              child: SizedBox(
                height: 24.h,
                width: double.infinity,
                child:  GestureDetector(
                      onTap: (){
                        controller.selectedCurrency.value = currency['code']!;
                        Get.back();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text('${currency['code']}  -  ${currency['name']}',
                            style: GoogleFonts.urbanist(fontSize: 20.sp, fontWeight: FontWeight.w700,
                            color: blackColor2)),
                             Obx((){
                              return  SizedBox(
                                
                                height: 24.h,
                                width: 24.w,
                                child: Center(child: 
                                SvgPicture.asset("assets/icons/tick.svg",
                                colorFilter: ColorFilter.mode( controller.selectedCurrency.value == currency['code'] ? Colors.amber:whiteColor,BlendMode.srcIn),)));
                             })
                        
                        ],
                      ),
                    )
              ),
            );
          },
        );
  }
}
