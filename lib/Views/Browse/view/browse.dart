import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/controller/browse_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/view/browse_history.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
       var theme = Theme.of(context);
      var textTheme = theme.textTheme;
      bool isDarkMode =
          theme.brightness == Brightness.dark; // Check if dark mode is active
          final controller=Get.put(BrowseController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top: 60.h,left: 20.w,right: 20.w),
          child: Column(
            children: [
                    Row(
                children: [
          Image.asset(logo, height: 28.h,width: 28.w,),
            SizedBox(width: 10.w,),
               Text("Browser",style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: blackColor2
               ),),
               Spacer(),
               SvgPicture.asset("assets/icons/msg2.svg", height: 28.h,width: 28.w,)
                ],
               ),
               SizedBox(height: 20.h,),
                         Obx(() {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            
                            color: controller.isAmountEmpty.value
                                ?isDarkMode?lightBlackColor2: lightWhiteColor
                                : lightGreenColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(18.r),
                            border: Border.all(
                              color: controller.isAmountEmpty.value
                                  ? isDarkMode?lightBlackColor2:lightWhiteColor
                                  : orange3,
                            ),
                          ),
                          child:  TextFormField(
                            cursorColor: orange3,
                            controller:controller.searchController,
                            onChanged: (value) {
                              // controller.filterTokens(value);
                              controller
                                  .updateAmount(); // Call this method to update the reactive value
                            },
                            decoration: InputDecoration(
                              suffixIcon: SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: Center(
                                child: SvgPicture.asset("assets/icons/Voice.svg"),
                              ),),
                              prefixIcon: SizedBox(
                                height: 16.h,
                                width: 16.w,
                                child: Center(child: SvgPicture.asset("assets/icons/search2.svg",colorFilter: 
                                ColorFilter.mode(controller.isAmountEmpty.value?grey2:orange3, BlendMode.srcIn),))),
                              border: InputBorder.none,
                              hintText: "Search or enter address",
                              hintStyle: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w400,
                                color: greyColor2,
                                fontSize: 18.sp,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                            ),
                          
                          ),
                        );
                      }),
                      
                     Obx(() => SizedBox(
                      height: 210.h,
                      width: double.infinity,
                       child: GridView.builder(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                       crossAxisCount: 4,
                                        
                                       crossAxisSpacing: 10,
                                       mainAxisSpacing: 10,
                                       childAspectRatio: 1,
                                     ),
                                     itemCount: controller.cryptoList.length,
                                     itemBuilder: (context, index) {
                                       final item = controller.cryptoList[index];
                                       return Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Image.asset(item.imagePath, width: 50, height: 50),
                                           const SizedBox(height: 5),
                                           Text(
                        item.name,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                                           ),
                                         ],
                                       );
                                     },
                                   ),
                     )),
          CustomDivider(),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("History",style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: blackColor2
            ),),
             GestureDetector(
              onTap: (){
                Get.to(()=>BrowseHistoryScreen(historyItems: controller.historyList,));
              },
               child: Text("See All",style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: orange3
                           ),),
             )
            ],
          ),
          
     SizedBox(
  height: 250.h,
  child: LayoutBuilder(
    builder: (context, constraints) {
      int crossAxisCount = 2; // Number of items per row
      int totalItems =controller.historyList.length>=6?6: controller.historyList.length;
      int rowCount = (totalItems / crossAxisCount).ceil(); // Calculate the number of rows

      return ListView.builder(
         physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: rowCount,
        itemBuilder: (context, rowIndex) {
          int startIndex = rowIndex * crossAxisCount;
          int endIndex = startIndex + crossAxisCount;
          endIndex = endIndex > totalItems ? totalItems : endIndex;

          return Column(
            children: [
              Row(
                children: List.generate(
                  endIndex - startIndex,
                  (index) {
                    final item = controller.historyList[startIndex + index];
                    return Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(item.imagePath, width: 48.w, height: 48.h),
                        title: Text(item.name, style:  GoogleFonts.urbanist(fontWeight: FontWeight.w700,fontSize: 20.sp,color: blackColor2)),
                        subtitle: Text(item.description, overflow: TextOverflow.ellipsis,style: GoogleFonts.urbanist(fontWeight: FontWeight.w800,fontSize: 14.sp,color: greyColor3),),
                        onTap: () {
                          // Handle tap if needed
                        },
                      ),
                    );
                  },
                ),
              ),
            CustomDivider()// Add Divider after each row except last
            ],
          );
        },
      );
    },
  ),
),
 
     SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Popular",style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: blackColor2
            ),),
             Text("See All",style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: orange3
            ),)
            ],
          ),
          
     SizedBox(
  height: 300.h,
  child: LayoutBuilder(
    builder: (context, constraints) {
      int crossAxisCount = 2; // Number of items per row
      int totalItems =controller.historyList.length>=6?6: controller.historyList.length;
      int rowCount = (totalItems / crossAxisCount).ceil(); // Calculate the number of rows

      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: rowCount,
        itemBuilder: (context, rowIndex) {
          int startIndex = rowIndex * crossAxisCount;
          int endIndex = startIndex + crossAxisCount;
          endIndex = endIndex > totalItems ? totalItems : endIndex;

          return Column(
            children: [
              Row(
                children: List.generate(
                  endIndex - startIndex,
                  (index) {
                    final item = controller.historyList[startIndex + index];
                    return Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(item.imagePath, width: 48.w, height: 48.h),
                        title: Text(item.name, style:  GoogleFonts.urbanist(fontWeight: FontWeight.w700,fontSize: 20.sp,color: blackColor2)),
                        subtitle: Text(item.description, overflow: TextOverflow.ellipsis,style: GoogleFonts.urbanist(fontWeight: FontWeight.w800,fontSize: 14.sp,color: greyColor3),),
                        onTap: () {
                          // Handle tap if needed
                        },
                      ),
                    );
                  },
                ),
              ),
            CustomDivider()// Add Divider after each row except last
            ],
          );
        },
      );
    },
  ),
),
 
 
  ],
          ),
        ),
      ),
    );
  }
}