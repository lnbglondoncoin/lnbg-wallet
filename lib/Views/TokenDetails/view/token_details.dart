import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/buy_coin.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/buy_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Receive/view/receive_coin_qr.dart';
import 'package:lnbg_crypto_wallet_app/Views/Receive/view/receive_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/send_coin.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/send_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/view/swap_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/transfer_token.dart';
import 'package:lnbg_crypto_wallet_app/Views/Transections/controller/transection_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class TokenDetailsScreen extends StatelessWidget {
final TokenData token;
 final transactionController = Get.find<TransactionController>();
   TokenDetailsScreen({super.key, required this.token,});

  @override
  Widget build(BuildContext context) {
        var theme = Theme.of(context);
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
backgroundColor: isDarkMode?lightBlackColor3:whiteColor,
        appBar: CustomAppBar(
        //  isSuffix: true,
          title:"${token.name} (${token.symbol})" ,
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
                      color:isDarkMode?greyColor: darkGreyColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800
                    ),),
                    const Spacer(),
                     Text("\$${token.priceInUsd.toStringAsFixed(2)}",style: GoogleFonts.urbanist(
                      color:isDarkMode?whiteColor: blackColor2,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800
                    ),),
                    SizedBox(width: 10.w,),
                     Text(token.trendPercentage.toStringAsFixed(2),style: GoogleFonts.urbanist(
                      color: skyColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800
                    ),),  
                  ],
                ),
                  SizedBox(height: 20.h,),
                  Center(child: Image.network(token.logoUrl,height: 80.h,width: 80.w,)),
                  SizedBox(height: 10.h,),
                   Center(
                     child: Text(token.balance.toStringAsFixed(2),style: GoogleFonts.urbanist(
                        color:isDarkMode?whiteColor: blackColor2,
                        fontSize: 48.sp,
                        fontWeight: FontWeight.w700
                      ),),
                   ), 
                     Center(
                       child: Text("\$${token.priceInUsd.toStringAsFixed(2)}",style: GoogleFonts.urbanist(
                        color:isDarkMode?whiteColor: blackColor2,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800
                                         ),),
                     ),
                    SizedBox(height: 20.h,),
                    const CustomDivider() ,
                    SizedBox(height: 20.h,),
                   Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                   Get.to(() => SendCoin(
                                token: token,
                              ));
                                 // Get.to(() =>  SendScreen());
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
                               Get.to(() => ReceiveCoinQR(
                                token: token,
                              ));
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
                             Get.to(() => BuyCoinScreen(
                                token: token,
                              ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 60.w,
                                  decoration:  BoxDecoration(
                                      color:isDarkMode?lightBlackColor: lightGreenColor.withValues(alpha:0.08), shape: BoxShape.circle),
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
                              Get.to(() => SwapView(
                                token: token,
                                isFirstTokenSelected: true,
                              ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 60.w,
                                  decoration:  BoxDecoration(
                                      color:isDarkMode?lightBlackColor:  lightGreenColor.withValues(alpha:0.08), shape: BoxShape.circle),
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
                                      color:isDarkMode?lightWhiteColor: darkGreyColor),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                 SizedBox(height: 20.h,),
                    const CustomDivider() ,
                    SizedBox(height: 20.h,), 
                     Text(
                                  "Today",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800,
                                      color:isDarkMode?greyColor: darkGreyColor),
                                )  ,
                                SizedBox(height: 20.h,),
              Obx((){
                               final allFilterTransactions = transactionController.transactions
    .where((transection) => transection.token == token.symbol.toUpperCase()&&transection.time.split('T')[0]==DateTime.now().toIso8601String().split('T')[0])
    .toList();
                         final sendTransactions = allFilterTransactions
    .where((transection) => transection.method == 'send')
    .toList();
                       final receiveTransections = allFilterTransactions
    .where((transection) => transection.method == 'receive')
    .toList();
                       final buyTransactions = allFilterTransactions
    .where((transection) => transection.method == 'buy')
    .toList();
                       final swapTransactions = allFilterTransactions
    .where((transection) => transection.method == 'swap')
    .toList();
 // final totalItems=sendTransactions.length+receiveTransections.length+buyTransactions.length+swapTransactions.length;
  final allTodayTransections =sendTransactions+buyTransactions+receiveTransections+swapTransactions;
                return    
                transactionController.isLoading.value?CircularProgressIndicator():
                allTodayTransections.isEmpty?Text("No Transections Made Today"):
                ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allTodayTransections.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  var transection=allTodayTransections[index];
                return                          GestureDetector(
                  onTap: (){
                    if(transection.method=='send'){
                      Get.to(()=>TransferToken(token: token,transection: transection,));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                        color: isDarkMode?lightBlackColor:lightBlack,
                        )
                      )
                    ),
                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Container(
                                      height: 48.h,
                                      width: 48.w,
                                      decoration:  BoxDecoration(
                                        
                                          color:isDarkMode?lightBlackColor2: lightGreenColor.withOpacity(0.08), shape: BoxShape.circle),
                                      child: Center(
                                        child: SvgPicture.asset(isDarkMode
                                            ?
                                            transection.method=="send"? optionImageList[0]:
                                            transection.method=="receive"? optionImageList[1]:
                                            transection.method=="buy"? optionImageList[2]:
                                             optionImageList[3]
                                            : 
                                              transection.method=="send"? optionImageList2[0]:
                                            transection.method=="receive"? optionImageList2[1]:
                                            transection.method=="buy"? optionImageList2[2]:
                                             optionImageList2[3]
                                            
                                           ),
                                      ),
                                    ) ,
                                    title:Text(
                                    transection.method.capitalizeFirst!,
                                      style: GoogleFonts.urbanist(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color:isDarkMode?whiteColor: blackColor2),
                                    ) ,
                                    subtitle: Text(
                                      maxLines: 1,
                                     transection.method=="send"? "To: ${transection.to}": "From: ${transection.to}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.urbanist(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w800,
                                          color:isDarkMode?greyColor: greyColor3),
                                    ),
                                    trailing: Text(
                                     "${transection.amount} ${transection.token}",
                                      style: GoogleFonts.urbanist(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color:isDarkMode?greyColor: blackColor2),
                                    ),
                                    ),
                  ),
                );   
                 
               });
              }),
               SizedBox(height: 40.h,)     ],
            ),
          ),
        ),
    );
  }
}