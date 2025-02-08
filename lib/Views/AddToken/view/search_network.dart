import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
import 'package:lnbg_crypto_wallet_app/Views/AddToken/controller/add_token_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';

class SearchNetworkScreen extends StatelessWidget {
  const SearchNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
      var textTheme = theme.textTheme;
      bool isDarkMode =
          theme.brightness == Brightness.dark; // Check if dark mode is active
    final controller=Get.put(AddTokenController());
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        isSuffix: true,
        title: "Select Network", iconPath: "assets/icons/search2.svg"),
        body:   Container(
    height: Get.height,
    width: double.infinity,
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w,),
      child:  Obx((){
        return  controller.isLoading.value?Center(
        child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [orange1, orange2], // Gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: SpinKitCircle(
                color: Colors.white, // Set a neutral color for blending
                size: 50.h,
              ),
            )
      ):
   controller.tokenList.isEmpty?Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
              //  controller.filterTokens(query);
              },
              child: Image.asset("assets/images/searchImage.png",height: 300.h,width: 300.w,)),
            Text(
               textAlign: TextAlign.center,
              "Not Found",style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: blackColor2
            ),),
             Text(
              textAlign: TextAlign.center,
              "Sorry, the keyword you entered cannot be found, please check again or search with another keyword.",style: GoogleFonts.urbanist(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: blackColor2
            ),)
          ],
        ),
      ),
    )
      :ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.tokenList.length,
        itemBuilder: (context,index){
        return Padding(
          padding:  EdgeInsets.only(bottom: index==controller.tokenList.length-1?80.h:0.h),
          child: GestureDetector(
            onTap: (){
              controller.changeNetwork( controller.tokenList[index]);
              Get.back();
            },
            child: Container(
              height: 70.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                  color: lightBlack
                ))
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    SizedBox(
                                                            height: 45.h,
                                                            width: 35.w,
                                                            child: Center(
                                                              child: Image.asset(
                                                               controller.tokenIcons[index],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 30.w,),
                                                          Text(
                                                               controller.tokenList[index],
                                                                style: GoogleFonts.urbanist(
                                                                    fontSize: 20.sp,
                                                                    fontWeight:
                                                                        FontWeight.w700,
                                                                    color: isDarkMode
                                                                        ? whiteColor
                                                                        : blackColor2),
                                                              ),
                   
                  ],
                ),
              ), 
            ),
          ),
        );
      });
      })
    ),
  ),

    );
  }
}