import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/controller/swap_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/view/select_coin_to_swap.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/view/swap_coin.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';

class SwapView extends StatefulWidget {
   final bool? isFirstTokenSelected;
  final TokenData? token;
   const SwapView({
    super.key, 
    this.isFirstTokenSelected,
    this.token,
  });

  @override
  State<SwapView> createState() => _SwapViewState();
}

class _SwapViewState extends State<SwapView> {
final controller=Get.put(SwapController());
  final walletCreatingCotroller = Get.find<WalletCreatingController>();
  @override
  void initState() {
    super.initState();
    // Handle the passed token if any
    if (widget.token != null) {
      if (widget.isFirstTokenSelected ?? false) {
        controller.firstToken.value = widget.token!;
         controller.secondToken.value = walletCreatingCotroller.tokenData[0];
      } else {
        if (walletCreatingCotroller.tokenData.isNotEmpty) {
     controller.firstToken.value = walletCreatingCotroller.tokenData[0];
      controller.secondToken.value = walletCreatingCotroller.tokenData[1];
   }
            
    controller.  oneFirstCoinEquelsSecondCoins.value=controller.firstToken.value.priceInUsd / controller.secondToken.value.priceInUsd;
  
      }
 
    }
  }
  @override
  Widget build(BuildContext context) {
          var theme = Theme.of(context);
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
        backgroundColor: isDarkMode?lightBlackColor3:whiteColor,
        appBar: const CustomAppBar(
          title: "Swap",
          iconPath: 'assets/icons/search.svg',
        ),
        body: Form(
          key: controller.swapFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),
              child: Column(
                children: [
                  Container(
                  //  height: 288.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      color:
                      isDarkMode?lightBlackColor2:
                       whiteColor,border: Border.all(
                      color:
                      isDarkMode?lightBlackColor:
                      lightBlack)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("You Pay",style: GoogleFonts.urbanist(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color:isDarkMode?greyColor: darkGreyColor
                        ),),
               
               Obx((){
                return          Row(children: [
                          Flexible(
                            child: TextFormField(
                               validator: (value) => controller.validateBLance(value),
                              controller: controller.balanceController,
                              
                              onChanged: (value) {
                               controller.updateAmount(value,controller.firstToken.value.priceInUsd);
                              },
                                keyboardType: const TextInputType.numberWithOptions(decimal: true), // Add this
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), // Add this
              LengthLimitingTextInputFormatter(10), // Optional: limit total length
            ],
           
                              decoration: InputDecoration(
                                
                                border: InputBorder.none,
                                hintText: "Enter balance",
                                hintStyle: GoogleFonts.urbanist(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  color:isDarkMode?greyColor.withValues(alpha:0.5): greyColor
                                )
                              ),
                              style: GoogleFonts.urbanist(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  color:isDarkMode?whiteColor: blackColor2
                                ),
                            ),
                          ),
                          //Spacer(),
                          SizedBox(
                            height: 24.h,
                            width: 24.w,
                            child: Center(
                              child: Image.network(controller.firstToken.value.logoUrl),
                            ),
                          ),
                           SizedBox(width: 5.w,),
                          Text(controller.firstToken.value.symbol,style:GoogleFonts.urbanist(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color:isDarkMode?whiteColor: blackColor2
                          ) ,),
                          SizedBox(width: 5.w,),
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>SelectCoinToSwap(firstCoin: true,));
                              
                            },
                            child: SizedBox(
                              height: 24.h,
                              width: 24.w,
                              child: Center(
                                child: SvgPicture.asset("assets/icons/arrowRight.svg",colorFilter: 
                                    ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn),),
                              ),
                            ),
                          ),
          
                        ],);
                   
               }),
                   Obx((){
                        return  Text("Balance: ${controller.cryptoAmount.value} ${controller.firstToken.value.symbol}",style: GoogleFonts.urbanist(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color:isDarkMode?greyColor: darkGreyColor
                        ),);
                       }),
                        SizedBox(height: 20.h,),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width/1.9,
                            child:  Container(
                              height: 1,
                              width: double.infinity,
                              color:isDarkMode?lightBlackColor: lightBlack,
                            )
                          ),
                          SizedBox(width: 8.w,),
                          Container(height: 44.h,
                          width: 44.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: lightGreenColor.withValues(alpha:0.08)
                          ),
                           child: Center(
                                  child: SvgPicture.asset("assets/icons/doubleArrow.svg",colorFilter: 
                                  ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn),),
                                ),
                          ),
                           SizedBox(width: 8.w,),
                           Flexible(
                             child: Container(
                                height: 1,
                               // width: double.infinity,
                                color:isDarkMode?lightBlackColor: lightBlack,
                               
                              ),
                           )
                        ],
                      ),
                      SizedBox(height: 20.h,),
                       Text("You Get",style: GoogleFonts.urbanist(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                           color:isDarkMode?greyColor: darkGreyColor
                        ),),
                        Obx((){
                          return Row(children: [
                         Flexible(
                           child: Text(
                         //   maxLines: 2,
                            controller.usdAmount2nd.value.toStringAsFixed(5),style: GoogleFonts.urbanist(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color:isDarkMode? greyColor:blackColor2
                                  ),),
                         ),
                          const Spacer(),
                          SizedBox(
                            height: 24.h,
                            width: 24.w,
                            child: Center(
                              child: Image.network(controller.secondToken.value.logoUrl),
                            ),
                          ),
                           SizedBox(width: 5.w,),
                          Text(controller.secondToken.value.symbol,style:GoogleFonts.urbanist(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color:isDarkMode?whiteColor: blackColor2
                          ) ,),
                          SizedBox(width: 5.w,),
                        GestureDetector(
                          onTap: (){
                             Get.to(()=>SelectCoinToSwap(firstCoin: false,));
                          },
                            child: SizedBox(
                              height: 24.h,
                              width: 24.w,
                              child: Center(
                                child: SvgPicture.asset("assets/icons/arrowRight.svg",colorFilter: 
                                    ColorFilter.mode(isDarkMode?lightGreenColor:orange3, BlendMode.srcIn),),
                              ),
                            ),
                          ),
          
                        ],);
                        }),
                       Obx((){
                        return  Text("Balance: ${controller.cryptoAmount2nd.value} ${controller.secondToken.value.symbol}",style: GoogleFonts.urbanist(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color:isDarkMode?greyColor: darkGreyColor
                        ),);
                       })
               ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                 Row(
                  children: [
                     Flexible(
                       child: Container(height: 32.h,
                                       
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(100.r),
                                         border: Border.all(color:isDarkMode?lightGreenColor: orange3,width: 2)
                                       ),
                                       child: Center(
                                         child: Text("25%",style: GoogleFonts.urbanist(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color:isDarkMode?lightGreenColor: orange3
                                         ),),
                                       ),
                                       ),
                     ),
                     SizedBox(width: 10.w,),
                      Flexible(
                       child: Container(height: 32.h,
                                       
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(100.r),
                                         border: Border.all( color:isDarkMode?lightGreenColor: orange3,width: 2)
                                       ),
                                       child: Center(
                                         child: Text("50%",style: GoogleFonts.urbanist(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color:isDarkMode?lightGreenColor: orange3
                                         ),),
                                       ),
                                       ),
                     ),
                     SizedBox(width: 10.w,),
                      Flexible(
                       child: Container(height: 32.h,
                                       
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(100.r),
                                         border: Border.all( color:isDarkMode?lightGreenColor: orange3,width: 2)
                                       ),
                                       child: Center(
                                         child: Text("75%",style: GoogleFonts.urbanist(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color:isDarkMode?lightGreenColor: orange3
                                         ),),
                                       ),
                                       ),
                     ),
                     SizedBox(width: 10.w,),
                      Flexible(
                       child: Container(height: 32.h,
                                       
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(100.r),
                                         border: Border.all( color:isDarkMode?lightGreenColor: orange3,width: 2)
                                       ),
                                       child: Center(
                                         child: Text("100%",style: GoogleFonts.urbanist(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                         color:isDarkMode?lightGreenColor: orange3
                                         ),),
                                       ),
                                       ),
                     )
                  ],
                 ),
                 SizedBox(height: 20.h,),
                Obx((){
                  return   Text("1 ${controller.firstToken.value.symbol} = \$${controller.oneFirstCoinEquelsSecondCoins.value} ${controller.secondToken.value.symbol}",style: GoogleFonts.urbanist(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color:isDarkMode?greyColor: darkGreyColor
                                         ),);
                })
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding:  EdgeInsets.all(20.h),
          child: isDarkMode?CustomGreenButton(buttonText: "Swap", onPressed: (){
          if(controller.validateForm()){
             Get.to(()=>SwapCoinScreen());
          }
          }):CustomButton(buttonText: "Swap", onPressed: (){
             if(controller.validateForm()){
             Get.to(()=>SwapCoinScreen());
          }
          }),
        ),
    );
  }
}