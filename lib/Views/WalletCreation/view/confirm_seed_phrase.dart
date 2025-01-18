import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/wallet_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_step_app_bar.dart';

class ConfirmSeedPhraseScreen extends StatelessWidget {
   ConfirmSeedPhraseScreen({super.key});
  final StepController controller = Get.put(StepController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
    appBar: CustomStepAppBar(
        onBackTap: () {
        controller.decreseIndexValue(2);
              Get.back();
        },
        currentIndex: controller.currentIndex, onWillPop: () { 
            controller.decreseIndexValue(2);
              Get.back();
         }, // Pass the RxInt
      ),   body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 25.w,vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDivider(),
                SizedBox(height: 10.h,),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Confirm Seed Phrase",style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w700,
                    fontSize: 32.sp,
                    color: orange3
                  ),),
                ),
                SizedBox(height: 10.h,),
                Text(
                  textAlign: TextAlign.center,
                  "Select each word in the order it was presented to you.",style: GoogleFonts.urbanist(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: darkGreyColor,
            ),),
                
  
                 SizedBox(height: 25.h,),
                CustomDivider(),
                SizedBox(height: 45.h,),
Center(
  child: Text("6.",style: GoogleFonts.urbanist(
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
    color: orange3
  ),),
),
SizedBox(height: 45.h,),
                Container(
                  height: 378.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient:  LinearGradient(
        colors: [Color(0xFFFACC15), Color(0xFFFFE580)],
      ),
      borderRadius: BorderRadius.circular(40.r)
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(2.h),
                    child: Container(
                      decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(40.r),
                            color: whiteColor,   
                      ),
                     
                      child: Padding(
                        padding:  EdgeInsets.all(10.h),
                        child:  GridViewBuilderWidget(items: controller.selectedSeeds,)
                        
                      )),
                  ),
                ),
                SizedBox(height: 25.h,),
   
          ],
            ),
          ),
            CustomDivider(),
       SizedBox(height: 200.h,)
        ],
      ),
    ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
 floatingActionButton:
    Padding(
            padding:  EdgeInsets.only(left: 20.w,top: 20.h,right: 20.w,bottom: 10.h),
            child: CustomButton(buttonText: "Next", onPressed: (){
   //Get.to(()=>ConfirmSeedPhraseScreen());
   controller.updateIndex(2);
            })
          ),
   
    );
  }
 
  

}



class GridViewBuilderWidget extends StatelessWidget {
  final List items;

  const GridViewBuilderWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3, // Width to height ratio
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            height: 45.h,
            decoration: BoxDecoration(
              color: greyColor4,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                items[index],
                style: GoogleFonts.urbanist(fontSize: 18.sp,color: darkGreyColor,fontWeight: FontWeight.w700),
              ),
            ),
          );
        },
      ),
    );
  }
}