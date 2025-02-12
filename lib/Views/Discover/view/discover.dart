import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/Discover/controller/descover_controlelr.dart';
import 'package:lnbg_crypto_wallet_app/Views/Discover/view/category.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoverController controller = Get.put(DiscoverController());
    return Scaffold(
    body: Padding(
      padding:  EdgeInsets.only(top: 60.h,left: 20.w,right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           
           Row(
            children: [
Image.asset(logo, height: 28.h,width: 28.w,),
  SizedBox(width: 10.w,),
           Text("Discover",style: GoogleFonts.poppins(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: blackColor2
           ),),
           Spacer(),
           SvgPicture.asset("assets/icons/search.svg", height: 28.h,width: 28.w,)
            ],
           ),
        
        //  Padding(
        //    padding:  EdgeInsets.symmetric( horizontal: 5.w,vertical: 30.h),
        //    child: Row(
        //     children: [
        //         Text("Staking",style: GoogleFonts.poppins(
        //       fontSize: 20.sp,
        //       fontWeight: FontWeight.w700,
        //       color: blackColor2
        //      ),), 
        //     ],
        //    ),
        //  )

     Obx(
  () => Expanded(
    child: ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: controller.categories.length,
      itemBuilder: (context, index) {
        var category = controller.categories[index];
        // var cryptos = controller.getCryptosByCategory(category);
        var crypto2 = index==0?controller.skatingCryptoList:index==1?controller.deFiTokens:
                index==2?controller.lendingBorrowing:index==3?controller.smartChainBSC:controller.draft;
                
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25.h, bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category,
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: blackColor2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                     Get.to(() => CoinsCategoryScreen(category: category, cryptos:crypto2 ));
                    },
                    child: Text(
                      "See All",
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: orange3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, cryptoIndex) {
                var crypto = index==0?controller.skatingCryptoList[cryptoIndex]:index==1?controller.deFiTokens[cryptoIndex]:
                index==2?controller.lendingBorrowing[cryptoIndex]:index==3?controller.smartChainBSC[cryptoIndex]:controller.draft[cryptoIndex];
                
                return Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: greyColor)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(crypto.imageUrl),
                      ),
                      title:   index==0? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${crypto.name} (${crypto.symbol})",
                            style: GoogleFonts.urbanist(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: blackColor2,
                            ),
                          ),Row(
                          children: [
                            Text("APR:",style: GoogleFonts.urbanist(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
                              color: greyColor3
                            ),),
                            SizedBox(width: 5.w,),
                             Text(
                              "${crypto.percentage}%",
                              style: GoogleFonts.urbanist(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: crypto.percentage.startsWith('+') ? skyColor : pinkColor,
                              ),
                            ),
                          ],
                        ),
                          
                        ],
                      ): Text(
                        "${crypto.name} (${crypto.symbol})",
                        style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: blackColor2,
                        ),
                      ),
                     
                      trailing: Visibility(
                        visible: index!=0,
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "\$${crypto.price.toStringAsFixed(2)}",
                            style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: blackColor2,
                            ),
                          ),
                          Text(
                            "${crypto.percentage}%",
                            style: GoogleFonts.urbanist(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: crypto.percentage.startsWith('+') ? skyColor : pinkColor,
                            ),
                          ),
                        ],
                      ),)
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    ),
  ),
),

        ],
      ),
    ),
    );
  }
}