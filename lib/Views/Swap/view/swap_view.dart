import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/controller/swap_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/view/select_coin_to_swap.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/view/swap_coin.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/shimmer_app_bar_widget.dart';

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
         controller.secondToken.value = walletCreatingCotroller.tokenData[1];
      } else {
        if (walletCreatingCotroller.tokenData.isNotEmpty) {
     controller.firstToken.value = walletCreatingCotroller.tokenData[1];
      controller.secondToken.value = walletCreatingCotroller.tokenData[2];
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
        appBar:  PreferredSize(preferredSize:  const Size.fromHeight(kToolbarHeight), child: Obx((){
        return controller.isLoading.value?ShimmerAppBar(isDarkMode: isDarkMode):CustomAppBar(
        title: "Swap",
        iconPath: 'assets/icons/search.svg',
        isSuffix: false,
      );
      })),
      
        body: Obx((){
          return controller.isLoading.value?shimmerLoadingView(isDarkMode):Form(
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
  controller: controller.balanceController,
  keyboardType: const TextInputType.numberWithOptions(decimal: true),
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'^\$?\d*\.?\d*')),
    LengthLimitingTextInputFormatter(11), // one extra for $ sign
  ],
  onChanged: (value) {
    if (!value.startsWith('\$')) {
      final newValue = '\$${value.replaceAll('\$', '')}';
      controller.balanceController.value = TextEditingValue(
        text: newValue,
        selection: TextSelection.collapsed(offset: newValue.length),
      );
    }
    controller.updateAmount(
      value.replaceAll('\$', ''), // send pure number for calculation
      controller.firstToken.value.priceInUsd,
    );
  },
  validator: (value) => controller.validateBLance(value),
  decoration: InputDecoration(
    border: InputBorder.none,
    hintText: "Enter balance(\$)",
    hintStyle: GoogleFonts.urbanist(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: isDarkMode ? greyColor.withAlpha(125) : greyColor,
    ),
  ),
  style: GoogleFonts.urbanist(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: isDarkMode ? whiteColor : blackColor2,
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
                              Get.toNamed(AppRoutes.selectCoinToSwap,arguments:true);
                            
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
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                         Flexible(
                           child: Text(
                         //   maxLines: 2,
                           "\$${ controller.usdAmount.value}",style: GoogleFonts.urbanist(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color:isDarkMode? greyColor:blackColor2
                                  ),),
                         ),
                          //const Spacer(),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                            Get.toNamed(AppRoutes.selectCoinToSwap,arguments:false);
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
                          ],
                         )
          
                        ],);
                        }),
                        SizedBox(height: 10.h,),
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
                       child: GestureDetector(
                         onTap: () => controller.calculatePercentage(25),
                         child: Obx(() => Container(height: 32.h,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(100.r),
                                         border: Border.all(
                                           color: controller.selectedPercentage.value == 25 
                                             ? isDarkMode ? lightGreenColor : orange3 
                                             : isDarkMode ? lightGreenColor : orange3,
                                           width: 2
                                         ),
                                         color: controller.selectedPercentage.value == 25 
                                           ? isDarkMode ? lightGreenColor.withOpacity(0.1) : orange3.withOpacity(0.1)
                                           : Colors.transparent,
                                       ),
                                       child: Center(
                                         child: Text("25%",style: GoogleFonts.urbanist(
                                           fontSize: 14.sp,
                                           fontWeight: FontWeight.w800,
                                           color: controller.selectedPercentage.value == 25 
                                             ? isDarkMode ? lightGreenColor : orange3
                                             : isDarkMode ? lightGreenColor : orange3
                                         ),),
                                       ),
                                       ),
                         ),
                       ),
                     ),
                     SizedBox(width: 10.w,),
                      Flexible(
                       child: GestureDetector(
                         onTap: () => controller.calculatePercentage(50),
                         child: Obx(() => Container(height: 32.h,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(100.r),
                                         border: Border.all(
                                           color: controller.selectedPercentage.value == 50 
                                             ? isDarkMode ? lightGreenColor : orange3 
                                             : isDarkMode ? lightGreenColor : orange3,
                                           width: 2
                                         ),
                                         color: controller.selectedPercentage.value == 50 
                                           ? isDarkMode ? lightGreenColor.withOpacity(0.1) : orange3.withOpacity(0.1)
                                           : Colors.transparent,
                                       ),
                                       child: Center(
                                         child: Text("50%",style: GoogleFonts.urbanist(
                                           fontSize: 14.sp,
                                           fontWeight: FontWeight.w800,
                                           color: controller.selectedPercentage.value == 50 
                                             ? isDarkMode ? lightGreenColor : orange3
                                             : isDarkMode ? lightGreenColor : orange3
                                         ),),
                                       ),
                                       ),
                         ),
                       ),
                     ),
                     SizedBox(width: 10.w,),
                      Flexible(
                       child: GestureDetector(
                         onTap: () => controller.calculatePercentage(75),
                         child: Obx(() => Container(height: 32.h,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(100.r),
                                         border: Border.all(
                                           color: controller.selectedPercentage.value == 75 
                                             ? isDarkMode ? lightGreenColor : orange3 
                                             : isDarkMode ? lightGreenColor : orange3,
                                           width: 2
                                         ),
                                         color: controller.selectedPercentage.value == 75 
                                           ? isDarkMode ? lightGreenColor.withOpacity(0.1) : orange3.withOpacity(0.1)
                                           : Colors.transparent,
                                       ),
                                       child: Center(
                                         child: Text("75%",style: GoogleFonts.urbanist(
                                           fontSize: 14.sp,
                                           fontWeight: FontWeight.w800,
                                           color: controller.selectedPercentage.value == 75 
                                             ? isDarkMode ? lightGreenColor : orange3
                                             : isDarkMode ? lightGreenColor : orange3
                                         ),),
                                       ),
                                       ),
                         ),
                       ),
                     ),
                     SizedBox(width: 10.w,),
                      Flexible(
                       child: GestureDetector(
                         onTap: () => controller.calculatePercentage(100),
                         child: Obx(() => Container(height: 32.h,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(100.r),
                                         border: Border.all(
                                           color: controller.selectedPercentage.value == 100 
                                             ? isDarkMode ? lightGreenColor : orange3 
                                             : isDarkMode ? lightGreenColor : orange3,
                                           width: 2
                                         ),
                                         color: controller.selectedPercentage.value == 100 
                                           ? isDarkMode ? lightGreenColor.withOpacity(0.1) : orange3.withOpacity(0.1)
                                           : Colors.transparent,
                                       ),
                                       child: Center(
                                         child: Text("100%",style: GoogleFonts.urbanist(
                                           fontSize: 14.sp,
                                           fontWeight: FontWeight.w800,
                                           color: controller.selectedPercentage.value == 100 
                                             ? isDarkMode ? lightGreenColor : orange3
                                             : isDarkMode ? lightGreenColor : orange3
                                         ),),
                                       ),
                                       ),
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
        );
     
        }),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding:  EdgeInsets.all(20.h),
          child: isDarkMode?CustomGreenButton(buttonText: "Swap", onPressed: (){
          if(controller.validateForm()){
            Get.toNamed(AppRoutes.swapCoinScreen);
             
          }
          }):CustomButton(buttonText: "Swap", onPressed: (){
             if(controller.validateForm()){
              Get.toNamed(AppRoutes.swapCoinScreen);
          }
          }),
        ),
    );
  }
  Widget shimmerLoadingView(bool isDarkMode) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: isDarkMode ? lightBlackColor2 : whiteColor,
            border: Border.all(
              color: isDarkMode ? lightBlackColor : lightBlack,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerBox(width: 80.w, height: 14.sp),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    shimmerBox(width: 150.w, height: 24.sp),
                    Spacer(),
                    shimmerCircle(size: 24.w),
                    SizedBox(width: 5.w),
                    shimmerBox(width: 40.w, height: 20.sp),
                    SizedBox(width: 5.w),
                    shimmerCircle(size: 24.w),
                  ],
                ),
                SizedBox(height: 10.h),
                shimmerBox(width: 180.w, height: 14.sp),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    shimmerLine(width: Get.width / 2.2),
                    SizedBox(width: 8.w),
                    shimmerCircle(size: 44.w),
                    SizedBox(width: 8.w),
                    Flexible(child: shimmerLine())
                  ],
                ),
                SizedBox(height: 20.h),
                shimmerBox(width: 80.w, height: 14.sp),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    shimmerBox(width: 150.w, height: 24.sp),
                    Row(
                      children: [
                        shimmerCircle(size: 24.w),
                        SizedBox(width: 5.w),
                        shimmerBox(width: 40.w, height: 20.sp),
                        SizedBox(width: 5.w),
                        shimmerCircle(size: 24.w),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                shimmerBox(width: 180.w, height: 14.sp),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) => Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: shimmerBox(height: 32.h),
            ),
          )),
        )
      ],
    ),
  );
}

// 🔸 Helper Widgets:
Widget shimmerBox({double? width, double? height}) {
  return Container(
    width: width ?? double.infinity,
    height: height ?? 20.h,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(8.r),
    ),
  );
}

Widget shimmerLine({double? width}) {
  return Container(
    width: width ?? double.infinity,
    height: 1,
    color: Colors.grey.shade300,
  );
}

Widget shimmerCircle({double size = 24}) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey.shade300,
    ),
  );
}

}