import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/controller/browse_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/view/clear_history_bottomsheet.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/shimmer_app_bar_widget.dart';
import 'package:shimmer/shimmer.dart';

class BrowseHistoryScreen extends StatelessWidget {
  const BrowseHistoryScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final controller = Get.put(BrowseController());
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(kToolbarHeight),
  child: Obx(() {
    return controller.isLoading.value
        ? ShimmerAppBar(isDarkMode: isDarkMode)
        : CustomAppBar(
            title: "History".tr,
            iconPath: "assets/icons/delete.svg",
            isSuffix: true,
            onSuffixTap: () {
              _showCustomBottomSheet(context);
            },
          );
  }),
),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child:  Obx((){
          return controller.isLoading.value?shimmerHistoryList(isDarkMode): 
          controller.historyResults.isEmpty?Center(
            child: Text("Your Search History is Empty".tr),
          ):
          ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.historyResults.length,
             physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = controller.historyResults[index];
              return Column(
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
                    // subtitle: Text(
                    //   "discription",
                    //   overflow: TextOverflow.ellipsis,
                    //   style: GoogleFonts.urbanist(
                    //       fontWeight: FontWeight.w800,
                    //       fontSize: 14.sp,
                    //       color: isDarkMode ? greyColor : greyColor3),
                    // ),
                    onTap: () {
                      // Handle tap if needed
                    },
                  ),
                  Visibility(
                      visible: index != controller.historyResults.length - 1,
                      child: CustomDivider())
                ],
              );
            });
        })
      ),
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full-screen height
      backgroundColor: Colors.transparent, // Transparent background
      builder: (context) {
        return const ClearHistoryBottomSheet();
      },
    );
  }

  Widget shimmerHistoryList(bool isDarkMode) {
  return ListView.builder(
    padding: EdgeInsets.zero,
    itemCount: 6, // Simulate 6 shimmer items (adjust as needed)
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Column(
        children: [
          Shimmer.fromColors(
            baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            highlightColor: isDarkMode ? Colors.grey[500]! : Colors.grey[100]!,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              title: Container(
                width: double.infinity,
                height: 16.h,
                color: Colors.white,
                margin: EdgeInsets.only(bottom: 6.h),
              ),
              subtitle: Container(
                width: 100.w,
                height: 14.h,
                color: Colors.white,
              ),
            ),
          ),
          if (index != 5) const CustomDivider(),
        ],
      );
    },
  );
}

}
