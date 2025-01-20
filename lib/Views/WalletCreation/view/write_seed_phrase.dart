import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/wallet_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/confirm_seed_phrase.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_step_app_bar.dart';

class WriteSeedPhraseScreen extends StatelessWidget {
   WriteSeedPhraseScreen({super.key});
  final StepController controller = Get.put(StepController());
  final walletCreatingController=Get.find<WalletCreatingController>();
 
  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      backgroundColor: whiteColor,
    appBar: CustomStepAppBar(
        onBackTap: () {
           Get.back();
        },
        currentIndex: controller.currentIndex, onWillPop: () { 
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
                    "Write Down Your Seed Phrase",style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w700,
                    fontSize: 32.sp,
                    color: orange3
                  ),),
                ),
                SizedBox(height: 10.h,),
                Text(
                  textAlign: TextAlign.center,
                  "This is your seed phrase. Write it down on a paper and keep it in a safe place. You'll be asked to re-enter this phrase (in order) on the next step.",style: GoogleFonts.urbanist(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: darkGreyColor,
            ),),
                
  
                 SizedBox(height: 25.h,),
                CustomDivider(),
                SizedBox(height: 25.h,),

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
                        child: GridViewBuilderWidget(),
                      )),
                  ),
                ),
                SizedBox(height: 25.h,),
              
// Container(
//   height: 378.h,
//   width: double.infinity,
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(40.r),
//     color: whiteColor,
//   ),
//   child: ShaderMask(
//     shaderCallback: (Rect bounds) {
//       return LinearGradient(
//         colors: [Color(0xFFFACC15), Color(0xFFFFE580)],
//       ).createShader(bounds);
//     },
//     child: Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(40.r),
//         border: Border.all(
//           width: 3, // Border thickness
//           color: Colors.white, // Base color
//         ),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey, // Explicit background color for the child
//           borderRadius: BorderRadius.circular(40.r), // Ensure border radius is consistent
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(10.h),
//           child: GridViewBuilderExample(),
//         ),
//       ),
//     ),
//   ),
// )

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
             walletCreatingController.shuffleFirstList(
  walletCreatingController.mnemonicWords.sublist(0, 6)
);
    Get.to(()=>ConfirmSeedPhraseScreen());
   controller.updateIndex(2);
            })
          ),
   
    );
  }
 
  

}



class GridViewBuilderWidget extends StatelessWidget {
  //final StepController controller = Get.put(StepController());
 final walletCreatingController=Get.find<WalletCreatingController>();
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
        itemCount: walletCreatingController.mnemonicWords.length,
        itemBuilder: (context, index) {
          return   GestureDetector(
            onTap: (){
             
            },
            child: Container(
              decoration: BoxDecoration(
                color:  greyColor4,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      "${(index+1).toString()} ",
                      style: GoogleFonts.urbanist(fontSize: 18.sp,color:  darkGreyColor,fontWeight: FontWeight.w700),
                    ),
                    Text(
                     walletCreatingController.mnemonicWords[index],
                      style: GoogleFonts.urbanist(fontSize: 18.sp,color: darkGreyColor,fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          );  },
      ),
    );
  }
}