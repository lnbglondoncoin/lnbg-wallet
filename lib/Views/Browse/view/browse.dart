import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/controller/browse_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/view/all_popular_tokens.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/view/browse_history.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:shimmer/shimmer.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
      final walletCreatingController = Get.find<WalletCreatingController>();
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active
    final controller = Get.put(BrowseController());
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w),
          child:          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    isDarkMode ? "assets/images/discoverd.png" : logo,
                    height: 28.h,
                    width: 28.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Browser".tr,
                    style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? whiteColor : blackColor2),
                  ),
                  // const Spacer(),
                  // SvgPicture.asset(
                  //   "assets/icons/msg2.svg",
                  //   height: 28.h,
                  //   width: 28.w,
                  //   colorFilter: ColorFilter.mode(
                  //       isDarkMode ? whiteColor : blackColor2, BlendMode.srcIn),
                  // )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(() {
                return 
                controller.isLoading.value&&walletCreatingController.isLoading.value?shimmerSearchField(isDarkMode):
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: controller.isAmountEmpty.value
                        ? isDarkMode
                            ? lightBlackColor2
                            : lightWhiteColor
                        : lightGreenColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: controller.isAmountEmpty.value
                          ? isDarkMode
                              ? lightBlackColor2
                              : lightWhiteColor
                          : isDarkMode
                              ? lightGreenColor
                              : orange3,
                    ),
                  ),
                  child: TextFormField(
                    cursorColor: orange3,
                    controller: controller.searchController,
                    onChanged: (value) {
                     
                      controller
                          .updateAmount(); // Call this method to update the reactive value
                    },
                    decoration: InputDecoration(
                      // suffixIcon: SizedBox(
                      //   height: 20.h,
                      //   width: 20.w,
                      //   child: Center(
                      //     child: SvgPicture.asset(
                      //       "assets/icons/Voice.svg",
                      //       colorFilter: ColorFilter.mode(
                      //           isDarkMode ? lightGreenColor : orange3,
                      //           BlendMode.srcIn),
                      //     ),
                      //   ),
                      // ),
                      prefixIcon: SizedBox(
                          height: 16.h,
                          width: 16.w,
                          child: Center(
                              child: SvgPicture.asset(
                            "assets/icons/search2.svg",
                            colorFilter: ColorFilter.mode(
                                controller.isAmountEmpty.value
                                    ? grey2
                                    : isDarkMode
                                        ? lightGreenColor
                                        : orange3,
                                BlendMode.srcIn),
                          ))),
                      border: InputBorder.none,
                      hintText: "Search".tr,
                      hintStyle: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w400,
                        color: greyColor2,
                        fontSize: 18.sp,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                    ),
                  ),
                );
              }),
             
             Obx((){
              return
              
controller.isSearching.value?shimmerSearchLoadingWidget(isDarkMode):
 controller.searchResult!=[]&&controller.searchController.text!=""?
           Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 20.h),
      Text(
        "Search Result:".tr,
        style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? whiteColor : blackColor2),
      ),
      SizedBox(height: 10.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.builder(
          shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: controller.searchResult.length,
             physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = controller.searchResult[index];
              return Obx((){
                return  Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading:
                        Image.network(item.logoUrl, width: 48.w, height: 48.h),
                    title: Text(item.name,
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                            color: isDarkMode ? whiteColor : blackColor2)),
                    subtitle: Text(
                      item.name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                          color: isDarkMode ? greyColor : greyColor3),
                    ),
                    onTap: () {
                      // Handle tap if needed
                    },
                  ),
                  Visibility(
                      visible: index != controller.searchResult.length - 1,
                      child: CustomDivider())
                ],
              );
              });
            }),
      ),
  
    ],
  ):
               Column(
                children: [
                  Obx((){
             
              return walletCreatingController.isLoading.value&&controller.isLoading.value?Center(
                child: CircularProgressIndicator(),
              ):
               walletCreatingController.hundredTokenData.isEmpty?
              Center(
                child: Text("No Tokens".tr),
              ):
               SizedBox(
                    height: 210.h,
                    width: double.infinity,
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount:8,
                      itemBuilder: (context, index) {
                        final item = walletCreatingController.hundredTokenData[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(item.logoUrl, width: 50, height: 50),
                            const SizedBox(height: 5),
                            Text(
                              item.name,
                              style: GoogleFonts.urbanist(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isDarkMode ? whiteColor : blackColor2),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                    ),
                  );
             }),
              const CustomDivider(),
              SizedBox(
                height: 20.h,
              ),
       Obx((){
        return walletCreatingController.isLoading.value&&controller.isLoading.value?shimmerLoadingHistoryLayout(isDarkMode):
        controller.historyResults.isEmpty?SizedBox():    Column(
            children: [
                 Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "History".tr,
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? whiteColor : blackColor2),
                  ),
                  GestureDetector(
                    onTap: () {
                       Get.toNamed(AppRoutes.browseHistoryScreen);
                   
                    },
                    child: Text(
                      "See All".tr,
                      style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? lightGreenColor : orange3),
                    ),
                  )
                ],
              ),
              SizedBox(
               // height: 250.h,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 2; // Number of items per row
                    int totalItems = controller.historyResults.length >= 8
                        ? 8
                        : controller.historyResults.length;
                    int rowCount = (totalItems / crossAxisCount)
                        .ceil(); // Calculate the number of rows

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: rowCount,
                      itemBuilder: (context, rowIndex) {
                        int startIndex = rowIndex * crossAxisCount;
                        int endIndex = startIndex + crossAxisCount;
                        endIndex =
                            endIndex > totalItems ? totalItems : endIndex;

                        return Column(
                          children: [
                            Row(
                              children: List.generate(
                                endIndex - startIndex,
                                (index) {
                                  final item = controller
                                      .historyResults[startIndex + index];
                                  return Expanded(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Image.network(item.logoUrl,
                                          width: 48.w, height: 48.h),
                                      title: Text(item.name,
                                          style: GoogleFonts.urbanist(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.sp,
                                              color: isDarkMode
                                                  ? whiteColor
                                                  : blackColor2)),
                                      // subtitle: Text(
                                      //   "Discription",
                                      //   overflow: TextOverflow.ellipsis,
                                      //   style: GoogleFonts.urbanist(
                                      //       fontWeight: FontWeight.w800,
                                      //       fontSize: 14.sp,
                                      //       color: isDarkMode
                                      //           ? greyColor
                                      //           : greyColor3),
                                      // ),
                                      onTap: () {
                                        // Handle tap if needed
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            const CustomDivider() // Add Divider after each row except last
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
           );
       }),







     Obx((){
      return walletCreatingController.isLoading.value&&controller.isLoading.value?shimmerPopularLayout(isDarkMode):
      walletCreatingController.hundredTokenData.isEmpty?SizedBox():
      Column(
        children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular".tr,
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? whiteColor : blackColor2),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.allPopularTokens);
                    
                    },
                    child: Text(
                      "See All".tr,
                      style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? lightGreenColor : orange3),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 300.h,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 2; // Number of items per row
                    int totalItems = 6;
                    int rowCount = (totalItems / crossAxisCount)
                        .ceil(); // Calculate the number of rows

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: rowCount,
                      itemBuilder: (context, rowIndex) {
                        int startIndex = rowIndex * crossAxisCount;
                        int endIndex = startIndex + crossAxisCount;
                        endIndex =
                            endIndex > totalItems ? totalItems : endIndex;

                        return Column(
                          children: [
                            Row(
                              children: List.generate(
                                endIndex - startIndex,
                                (index) {
                                  final item = walletCreatingController
                                      .hundredTokenData[startIndex + index];
                                  return Expanded(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Image.network(item.logoUrl,
                                          width: 48.w, height: 48.h),
                                      title: Text(item.name,
                                          style: GoogleFonts.urbanist(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.sp,
                                              color: isDarkMode
                                                  ? whiteColor
                                                  : blackColor2)),
                                      // subtitle: Text(
                                      //   "Discription",
                                      //   overflow: TextOverflow.ellipsis,
                                      //   style: GoogleFonts.urbanist(
                                      //       fontWeight: FontWeight.w800,
                                      //       fontSize: 14.sp,
                                      //       color: isDarkMode
                                      //           ? greyColor
                                      //           : greyColor3),
                                      // ),
                                      onTap: () {
                                        // Handle tap if needed
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            const CustomDivider() // Add Divider after each row except last
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
       
            
        ],
      );
     })    ],
              );
             })
                  ],
          )  ),
      ),
    );
  }

  Widget shimmerSearchLoadingWidget(bool isDarkMode) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 20.h),
      Shimmer.fromColors(
        baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
        highlightColor: isDarkMode ? Colors.grey[400]! : Colors.grey[100]!,
        child: Container(
          width: 150.w,
          height: 20.h,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 10.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: 5, // Temporary item count for shimmer effect
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Shimmer.fromColors(
                    baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                    highlightColor: isDarkMode ? Colors.grey[400]! : Colors.grey[100]!,
                    child: Container(
                      width: 48.w,
                      height: 48.h,
                      color: Colors.white,
                    ),
                  ),
                  title: Shimmer.fromColors(
                    baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                    highlightColor: isDarkMode ? Colors.grey[400]! : Colors.grey[100]!,
                    child: Container(
                      width: 150.w,
                      height: 16.h,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Shimmer.fromColors(
                    baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                    highlightColor: isDarkMode ? Colors.grey[400]! : Colors.grey[100]!,
                    child: Container(
                      width: 100.w,
                      height: 12.h,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    // Handle tap if needed
                  },
                ),
                Visibility(
                    visible: index != 4,
                    child: Divider(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ))
              ],
            );
          },
        ),
      ),
    ],
  );
}

Widget shimmerLoadingHistoryLayout(bool isDarkMode) {
  return Column(
    children: List.generate(3, (row) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: List.generate(2, (index) {
            return Expanded(
              child: Shimmer.fromColors(
                baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                highlightColor: isDarkMode ? Colors.grey[500]! : Colors.grey[100]!,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  title: Container(
                    height: 16.h,
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                  ),
                  subtitle: Container(
                    height: 12.h,
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 4.h),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    }),
  );
}


Widget shimmerPopularLayout(bool isDarkMode) {
  return Column(
    children: [
      // Header shimmer
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Shimmer.fromColors(
              baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
              highlightColor: isDarkMode ? Colors.grey[500]! : Colors.grey[100]!,
              child: Container(
                height: 20.h,
                width: 100.w,
                color: Colors.white,
              ),
            ),
            Shimmer.fromColors(
              baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
              highlightColor: isDarkMode ? Colors.grey[500]! : Colors.grey[100]!,
              child: Container(
                height: 20.h,
                width: 60.w,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 300.h,
        child: Column(
          children: List.generate(3, (row) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                children: List.generate(2, (index) {
                  return Expanded(
                    child: Shimmer.fromColors(
                      baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                      highlightColor: isDarkMode ? Colors.grey[500]! : Colors.grey[100]!,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        title: Container(
                          height: 16.h,
                          width: double.infinity,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                        ),
                        subtitle: Container(
                          height: 12.h,
                          width: double.infinity,
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 4.h),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ),
    ],
  );
}


Widget shimmerSearchField(bool isDarkMode) {
  return Shimmer.fromColors(
    baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
    highlightColor: isDarkMode ? Colors.grey[500]! : Colors.grey[100]!,
    child: Container(
      width: double.infinity,
      height: 60.h, // Adjust based on your actual text field height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              height: 16.h,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    ),
  );
}

}

