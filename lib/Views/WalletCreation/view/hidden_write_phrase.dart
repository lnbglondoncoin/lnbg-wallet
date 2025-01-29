import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/wallet_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/write_seed_phrase.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_step_app_bar.dart';

class HiddenWriteSeedPhraseScreen extends StatelessWidget {
   HiddenWriteSeedPhraseScreen({super.key});
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
      ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 25.w,vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomDivider(),
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
                const CustomDivider(),
                SizedBox(height: 25.h,),

                       Stack(
                children: [
                  // Yellow Gradient Container with GridView
                  Container(
                    height: 378.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                     color:whiteColor,
                      borderRadius: BorderRadius.circular(40.r),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 10,
                          blurRadius: 10,
                          color: Colors.pink.withOpacity(0.05)
                        )
                      ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.r),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: GridViewBuilderExample(),
                        ),
                      ),
                    ),
                  ),

                  // Blurred Overlay Limited to the Yellow Container
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.r), // Same border radius for alignment
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.5, sigmaY:2.5),
                        child: Container(
                           color: Colors.white.withOpacity(0.8), // Semi-transparent overlay
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Tap to reveal your seed phrase",
                                  style: GoogleFonts.urbanist(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: blackColor2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "Make sure no one is watching your screen.",
                                  style: GoogleFonts.urbanist(fontSize: 14.sp,fontWeight: FontWeight.w500,
                                  color: darkGreyColor),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20.h),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: orange3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                  ),
                                  onPressed: () {
                                   Get.to(()=>WriteSeedPhraseScreen());
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.remove_red_eye,color: whiteColor,),
                                      SizedBox(width: 8.w),
                                      Text("View", style: GoogleFonts.urbanist(fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: whiteColor)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
           SizedBox(height: 25.h,),
          

          ],
            ),
          ),
                const CustomDivider(),
       SizedBox(height: 200.h,)
        ],
      ),
    ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
 floatingActionButton:
    Padding(
            padding:  EdgeInsets.only(left: 20.w,top: 20.h,right: 20.w,bottom: 10.h),
            child: CustomButton(buttonText: "Next", onPressed: ()async{
   final mnemonic=walletCreatingController.generateMnemonic();
   final privateKey=await walletCreatingController.getPrivateKey(mnemonic);
   final publicKey= await walletCreatingController.getPublicKey(privateKey);
 
            })
          ),
   
    );
  }
  
 
  

}



class GridViewBuilderExample extends StatelessWidget {
  final List<String> items = [
    '1. material',
    '7. space',
    '2. wristn',
    '8. bench',
    '3. option',
    '9. payment',
    '4. skate',
    '10. bomb',
    '5. harbor',
    '11. hint',
    '6. peart',
    '12. maze'
  ];

   GridViewBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3, // Width to height ratio
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
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