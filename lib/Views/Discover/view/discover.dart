import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/Discover/controller/descover_controlelr.dart';
import 'package:lnbg_crypto_wallet_app/Views/Discover/view/category.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    final DiscoverController controller = Get.put(DiscoverController());
        // Reset the search query when screen is shown again
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.searchQuery.value = '';
      controller.searchController.clear();
    });
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      body: Obx((){
        return controller.isLoading.value? discoverSkeletonLoader(isDarkMode):Padding(
        padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  "Discover",
                  style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? whiteColor : blackColor2),
                ),
               SizedBox(width: 20.w,),
               /// Search Field
                    Flexible(
                      child: SizedBox(
                       //  height: 100.h,
                        // width: double.infinity,
                        child: TextField(
                          controller: controller.searchController,
                          onChanged: (value) => controller.searchQuery.value = value,
                          decoration: InputDecoration(
                            hintText: "Search categories or tokens",
                            hintStyle: GoogleFonts.poppins(
                              color: isDarkMode ? greyColor : Colors.grey,
                              fontSize: 14.sp,
                            ),
                            filled: true,
                            fillColor: isDarkMode ? lightBlackColor : Colors.grey.shade100,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(Icons.search,
                                color: isDarkMode ? whiteColor : blackColor2),
                          ),
                        ),
                      ),
                    ),  
              ],
            ),
        Obx((){
          final filteredMap = controller.filteredCategoriesWithTokens;
                      final filteredCategories = filteredMap.keys.toList();

          return Expanded(
                child:
                controller.filteredCategoriesWithTokens.isEmpty
      ?Center(
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off,
                    size: 60.sp,
                    color: isDarkMode ? greyColor : Colors.grey),
                SizedBox(height: 12.h),
                Text(
                  "No results found",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? greyColor : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ):
                 ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                     final category = filteredCategories[index];
                            final tokens = filteredMap[category]!;

                    return Padding(
                      padding:  EdgeInsets.only(bottom: index== filteredCategories.length-1?50.h:0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 25.h, bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                 (category).capitalizeFirst!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: isDarkMode ? whiteColor : blackColor2,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => CoinsCategoryScreen(
                                        category: category,));
                                  },
                                  child: Text(
                                    "See All",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          isDarkMode ? lightGreenColor : orange3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: tokens.length,
                            itemBuilder: (context, tokenIndex) {
                              final token = tokens[tokenIndex];
                      
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: isDarkMode
                                              ? lightBlackColor
                                              : greyColor)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
                                  child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            NetworkImage(token.logoUrl),
                                      ),
                                      title: Text(
                                              "${token.name} (${token.symbol})",
                                              style: GoogleFonts.urbanist(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w700,
                                                color: isDarkMode
                                                    ? whiteColor
                                                    : blackColor2,
                                              ),
                                            ),
                                            subtitle:         Row(
                                                  children: [
                                                    Text(
                                                      "APR:",
                                                      style: GoogleFonts.urbanist(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: isDarkMode
                                                              ? greyColor3
                                                              : greyColor3),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text(
                                                      "${token.trendPercentage.toStringAsFixed(2)}%",
                                                      style: GoogleFonts.urbanist(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: token.trendPercentage.toString()
                                                                .startsWith('-')
                                                            ? pinkColor
                                                            : skyColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            
                                      trailing: Text(
                                              "\$${token.priceInUsd.toStringAsFixed(2)}",
                                              style: GoogleFonts.urbanist(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w700,
                                                color: blackColor2,
                                              ),
                                            ), ),     ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
        })
          ],
        ),
      );
      })  );
  }
  /// Skeleton Loader Widget for DiscoverView
Widget discoverSkeletonLoader(bool isDarkMode) {
  return ListView.builder(
    padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w),
    itemCount: 5, // Fake categories
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category title shimmer
          Padding(
            padding: EdgeInsets.only(top: 25.h, bottom: 10.h),
            child: Shimmer.fromColors(
              baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
              highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
              child: Container(
                height: 24.h,
                width: 120.w,
                color: Colors.grey,
              ),
            ),
          ),
          // 3 fake list items for tokens
          ...List.generate(3, (_) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Shimmer.fromColors(
                baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
                highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            );
          }),
        ],
      );
    },
  );
}

}
