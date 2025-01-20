import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/wallet_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_step_app_bar.dart';

class ConfirmSeedPhrase2Screen extends StatelessWidget {
   ConfirmSeedPhrase2Screen({super.key});
  final StepController controller = Get.put(StepController());
  final walletCreatingController=Get.find<WalletCreatingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
    appBar: CustomStepAppBar(
        onBackTap: () {
        controller.decreseIndexValue(2);
      walletCreatingController.indexes.clear();
     /// walletCreatingController.shuffledList.clear();
       walletCreatingController.changeisTrue(true);
      walletCreatingController.orderList.clear();
              Get.back();
        },
        currentIndex: controller.currentIndex, onWillPop: () { 
            controller.decreseIndexValue(2);
            walletCreatingController.indexes.clear();
            walletCreatingController.changeisTrue(true);
     // walletCreatingController.shuffledList.clear();
      walletCreatingController.orderList.clear();
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
  child: Text("12",style: GoogleFonts.urbanist(
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
    color: orange3
  ),),
),
SizedBox(height: 45.h,),
Obx((){
  return     Container(
  width: double.infinity,
  decoration: BoxDecoration(
    gradient: walletCreatingController.isTrue.value?LinearGradient(
      colors: [Color(0xFFFACC15), Color(0xFFFFE580)],
    ):LinearGradient(
      colors: [redColor, redColor],
    ),
    borderRadius: BorderRadius.circular(40.r),
  ),
  child: Padding(
    padding: EdgeInsets.all(2.h),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        color: whiteColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(20.h),
        child: GridView.builder(
          shrinkWrap: true, // Ensures the GridView takes only the space it needs
          physics: NeverScrollableScrollPhysics(), // Prevents scrolling in GridView
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 2 columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3, // Width to height ratio
          ),
          itemCount: walletCreatingController.shuffledList.length,
          itemBuilder: (context, index) {
            var suffeledItem= walletCreatingController.shuffledList[index];
            return Obx((){
              return  GestureDetector(
              onTap: (){
                walletCreatingController.addInOrderList(suffeledItem);
                walletCreatingController.addIndexesToList(index);
              },
              child: Container(
                height: 45.h,
                decoration: BoxDecoration(
                  color: walletCreatingController.indexes.contains(index)?orange3:greyColor4,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    suffeledItem,
                    style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      color: walletCreatingController.indexes.contains(index)?whiteColor:darkGreyColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            );
            });
          },
        ),
      ),
    ),
  ),
);

}),
  SizedBox(height: 70.h,),
 SizedBox(
  height: 3.h,
   child: ListView.builder(
    itemCount: 12,
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context,index){
    return  Padding(
      padding:  EdgeInsets.only(right: 3.w),
      child:  Container(
        height: 3.h,
        width: 24.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.r),
      gradient:   LinearGradient(colors:[
        lightPrimaryColor,primaryColor,
      ])
      ),
      )
    
    );
   }),
 )
   
          ],
            ),
          ),
          SizedBox(height: 50.h,),
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
               walletCreatingController.changeisTrue(true);
              if (listEquals(walletCreatingController.secondHalfofMnemonic, walletCreatingController.orderList)) {
  Get.snackbar('Success', 'Lists match!');
      _showPopup(context);
} else {
   walletCreatingController.changeisTrue(false);
  Get.snackbar('Error', 'Order do not match!,Please tap phrases in the order provided to you');
}
              print("second mnemonic is :${walletCreatingController.secondHalfofMnemonic}");
              print("order list is :${walletCreatingController.orderList}");
  
   
            })
          ),
   
    );
  }
 
  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
         contentPadding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
         actionsPadding:  EdgeInsets.only(left: 30.w,bottom: 20.h,right: 30.w,top: 10.h),
        backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
            
          ),
          icon: Image.asset("assets/images/success.png",height: 180.h,
          width: 186.w,),
          title: Text("Successful!",style: GoogleFonts.urbanist(
            fontSize: 24.sp,fontWeight: FontWeight.w700,
            color: orange3
          ),),
          content: Text("You've successfully protected your wallet. Remember to keep your seed phrase safe, it's your responsibility!",
          style: GoogleFonts.urbanist(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: blackColor2)),
          actions: [
          GestureDetector(
            onTap: (){
              
            },
            child: Container(
              height: 58.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                gradient: LinearGradient(colors: 
                [
                 orange2, orange1 
                ])
              ),
              child: Center(
                child: Text("OK",style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  color: whiteColor
                ),),
              ),
            ),
          ),
        
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 20.h),
            child: Text("Your seeed phrase in Settings > Security & Privacy",style: GoogleFonts.urbanist(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: blackColor2
            ),),
          )
          ],
        );
      },
    );
  }
 

}


