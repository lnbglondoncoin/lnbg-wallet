import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
import 'package:lnbg_crypto_wallet_app/Models/crypto_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/buy_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Receive/view/receive_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/send_screen.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class CoinProperties extends StatelessWidget {
  final CryptoModel crypto;
  const CoinProperties({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
        var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
        backgroundColor:isDarkMode?lightBlackColor3:whiteColor,
      appBar: CustomAppBar(title:crypto.name , iconPath: "assets/icons/graphIcon2.svg",isSuffix: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Coin",style: GoogleFonts.urbanist(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color:isDarkMode?greyColor: darkGreyColor  
                  ),),
                  Spacer(),
                   Text("32.75",style: GoogleFonts.urbanist(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color:  isDarkMode?whiteColor: blackColor2  
                  ),),
                  SizedBox(width: 10.w,),
                   Text(crypto.percentage,style: GoogleFonts.urbanist(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: crypto.percentage.startsWith('+')? skyColor : pinkColor  
                  ),),
                  
                ],
              ),
              SizedBox(height: 20.h,),
              Center(
                child: Image.asset(crypto.imageUrl,height: 80.h,width: 80.w,),
              ),
               Center(
                 child: Text("256 ${crypto.symbol}",style: GoogleFonts.urbanist(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w700,
                      color:isDarkMode?whiteColor:  blackColor2
                    ),),
               ),
            
                   Center(
                     child: Text("\$8,573.58",style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: isDarkMode?whiteColor: blackColor2
                                       ),),
                   ),


SizedBox(height: 20.h,),
                   CustomDivider() ,
                    SizedBox(height: 20.h,),
                   Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                 // Get.to(() => const SendScreen());
                                },
                                child: Container(
                                  height: 60.h,
                                  width: 60.w,
                                  decoration:  BoxDecoration(
                                      color:isDarkMode?lightBlackColor: lightGreenColor.withOpacity(0.08), shape: BoxShape.circle),
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
                                    color:isDarkMode?lightWhiteColor: darkGreyColor),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() =>  ReceiveView());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 60.w,
                                  decoration:  BoxDecoration(
                                      color:isDarkMode?lightBlackColor: lightGreenColor.withOpacity(0.08), shape: BoxShape.circle),
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
                                      color:isDarkMode?lightWhiteColor: darkGreyColor),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() =>  BuyView());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 60.w,
                                  decoration:  BoxDecoration(
                                      color:isDarkMode?lightBlackColor: lightGreenColor.withOpacity(0.08), shape: BoxShape.circle),
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
                                      color:isDarkMode?lightWhiteColor: darkGreyColor),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                            //  Get.to(() => SwapView());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 60.w,
                                  decoration:  BoxDecoration(
                                      color:isDarkMode?lightBlackColor: lightGreenColor.withOpacity(0.08), shape: BoxShape.circle),
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
                                  "Stake",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color:isDarkMode?lightWhiteColor: darkGreyColor),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                 SizedBox(height: 20.h,),
                    CustomDivider() ,
                    SizedBox(height: 20.h,), 
                     Text(
                                  "Today",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800,
                                      color:isDarkMode?greyColor: darkGreyColor),
                                )  ,
                                SizedBox(height: 20.h,),
               ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (context,index){
                return                          GestureDetector(
                  onTap: (){
                    // if(index==3){
                    //   Get.to(()=>TransferToken(tokenPrice: tokenPrice, priceDolor: priceDolor, tokenSuffix: '${prceInTokenshortWord.split(' ').last}', percentage: percentage, coinName: coinName,));
                    // }
                  },
                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Container(
                                    height: 48.h,
                                    width: 48.w,
                                    decoration:  BoxDecoration(
                                        color:isDarkMode?lightBlackColor2: lightGreenColor.withOpacity(0.08), shape: BoxShape.circle),
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
                                        color:isDarkMode?whiteColor: blackColor2),
                                  ) ,
                                  subtitle: Text(
                                    maxLines: 1,
                                    index==2?"Address: ${optionsSubtitles[2]}":"To: ${optionsSubtitles[index]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.urbanist(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w800,
                                        color:isDarkMode?greyColor: greyColor3),
                                  ),
                                  trailing: Text(
                                   "${crypto.price} ${crypto.symbol}",
                                    style: GoogleFonts.urbanist(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                        color:isDarkMode?whiteColor: blackColor2),
                                  ),
                                  ),
                );   
                 
               }),
               SizedBox(height: 40.h,)  
            ],
          ),
        ),
      ),
    );
  }
}