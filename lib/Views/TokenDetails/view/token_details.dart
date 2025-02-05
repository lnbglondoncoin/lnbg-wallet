import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/buy_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Notifications/view/notification_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Receive/view/receive_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/ScanQRCode/view/scan_code.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/send_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/view/swap_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/transfer_token.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class TokenDetailsScreen extends StatelessWidget {
final String coinIconPath;
final String coinName;
final String tokenPrice;
final String percentage;
final String prceInTokenshortWord;
final String priceDolor;

  const TokenDetailsScreen({super.key, required this.coinIconPath, required this.coinName, required this.tokenPrice, required this.percentage, required this.prceInTokenshortWord, required this.priceDolor});

  @override
  Widget build(BuildContext context) {
        var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
backgroundColor:whiteColor,
        appBar: CustomAppBar(
          isSuffix: true,
          title:"$coinName (${prceInTokenshortWord.split(' ').last})" ,
          iconPath: 'assets/icons/graphIcon2.svg',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Coin",style: GoogleFonts.urbanist(
                      color: darkGreyColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800
                    ),),
                    Spacer(),
                     Text(priceDolor,style: GoogleFonts.urbanist(
                      color: blackColor2,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800
                    ),),
                    SizedBox(width: 10.w,),
                     Text(percentage,style: GoogleFonts.urbanist(
                      color: skyColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800
                    ),),  
                  ],
                ),
                  SizedBox(height: 20.h,),
                  Center(child: Image.asset(coinIconPath,height: 80.h,width: 80.w,)),
                  SizedBox(height: 10.h,),
                   Center(
                     child: Text(tokenPrice,style: GoogleFonts.urbanist(
                        color: blackColor2,
                        fontSize: 48.sp,
                        fontWeight: FontWeight.w700
                      ),),
                   ), 
                     Center(
                       child: Text(priceDolor,style: GoogleFonts.urbanist(
                        color: blackColor2,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800
                                         ),),
                     ),
                    SizedBox(height: 20.h,),
                    CustomDivider2() ,
                    SizedBox(height: 20.h,),
                   Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const SendScreen());
                                },
                                child: Container(
                                  height: 60.h,
                                  width: 60.w,
                                  decoration:  BoxDecoration(
                                      color: lightGreenColor.withOpacity(0.08), shape: BoxShape.circle),
                                  child: Center(
                                    child: SvgPicture.asset(isDarkMode
                                        ? "assets/icons/chat2.svg"
                                        : "assets/icons/chat.svg"),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Send",
                                style: GoogleFonts.urbanist(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: darkGreyColor),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const ReceiveView());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 60.w,
                                  decoration:  BoxDecoration(
                                      color: lightGreenColor.withOpacity(0.08), shape: BoxShape.circle),
                                  child: Center(
                                    child: SvgPicture.asset(isDarkMode
                                        ? "assets/icons/receive2.svg"
                                        : "assets/icons/receive.svg"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Receive",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: darkGreyColor),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const BuyView());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 60.w,
                                  decoration:  BoxDecoration(
                                      color: lightGreenColor.withOpacity(0.08), shape: BoxShape.circle),
                                  child: Center(
                                    child: SvgPicture.asset(isDarkMode
                                        ? "assets/icons/cart2.svg"
                                        : "assets/icons/cart.svg"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Buy",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: darkGreyColor),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SwapView());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 60.w,
                                  decoration:  BoxDecoration(
                                      color: lightGreenColor.withOpacity(0.08), shape: BoxShape.circle),
                                  child: Center(
                                    child: SvgPicture.asset(isDarkMode
                                        ? "assets/icons/Swap2.svg"
                                        : "assets/icons/Swap.svg"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Swap",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: darkGreyColor),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                 SizedBox(height: 20.h,),
                    CustomDivider2() ,
                    SizedBox(height: 20.h,), 
                     Text(
                                  "Today",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800,
                                      color: darkGreyColor),
                                )  ,
                                SizedBox(height: 20.h,),
               ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (context,index){
                return                          GestureDetector(
                  onTap: (){
                    if(index==3){
                      Get.to(()=>TransferToken(tokenPrice: tokenPrice, priceDolor: priceDolor, tokenSuffix: '${prceInTokenshortWord.split(' ').last}', percentage: percentage, coinName: coinName,));
                    }
                  },
                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Container(
                                    height: 48.h,
                                    width: 48.w,
                                    decoration:  BoxDecoration(
                                        color: lightGreenColor.withOpacity(0.08), shape: BoxShape.circle),
                                    child: Center(
                                      child: SvgPicture.asset(isDarkMode
                                          ? optionImageList[index]
                                          : optionImageList2[index]),
                                    ),
                                  ) ,
                                  title:Text(
                                    options[index],
                                    style: GoogleFonts.urbanist(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        color: blackColor2),
                                  ) ,
                                  subtitle: Text(
                                    index==2?"Address: ${optionsSubtitles[2]}":"To: ${optionsSubtitles[index]}",
                                    style: GoogleFonts.urbanist(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w800,
                                        color: greyColor3),
                                  ),
                                  trailing: Text(
                                   "${optionsPrice[index]} ${prceInTokenshortWord.split(' ').last}",
                                    style: GoogleFonts.urbanist(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                        color: blackColor2),
                                  ),
                                  ),
                );   
                 
               }),
               SizedBox(height: 40.h,)     ],
            ),
          ),
        ),
    );
  }
}