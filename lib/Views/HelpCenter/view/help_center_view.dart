import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/HelpCenter/controller/help_center_contrller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';

class HelpCenterScreen extends StatelessWidget {
  HelpCenterScreen({super.key});
  final controller = Get.put(HelpCenterController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
      appBar: const CustomAppBar(
          isSuffix: false,
          title: "Help Center",
          iconPath: "assets/icons/msg2.svg"),
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            // Tabs
            // Padding(
            //   padding: EdgeInsets.only(left: 25.w),
            //   child: SizedBox(
            //     height: 38.h,
            //     child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         physics: const BouncingScrollPhysics(),
            //         shrinkWrap: true,
            //         itemCount: controller.tabs.length,
            //         itemBuilder: (context, index) {
            //           return Padding(
            //             padding: EdgeInsets.only(right: 12.w),
            //             child: GestureDetector(
            //                 onTap: () => controller.selectedTab.value = index,
            //                 child: Obx(() {
            //                   return Container(
            //                     padding: EdgeInsets.symmetric(
            //                         horizontal: 12.w, vertical: 6.h),
            //                     decoration: BoxDecoration(
            //                       color: controller.selectedTab.value == index
            //                           ? isDarkMode
            //                               ? lightGreenColor
            //                               : orange3
            //                           : Colors.transparent,
            //                       borderRadius: BorderRadius.circular(20.r),
            //                       border: Border.all(
            //                           color: isDarkMode
            //                               ? lightGreenColor
            //                               : orange3,
            //                           width: 2),
            //                     ),
            //                     child: Text(
            //                       controller.tabs[index],
            //                       style: GoogleFonts.urbanist(
            //                         fontSize: 18.sp,
            //                         fontWeight: FontWeight.w800,
            //                         color: controller.selectedTab.value == index
            //                             ? whiteColor
            //                             : isDarkMode
            //                                 ? lightGreenColor
            //                                 : orange3,
            //                       ),
            //                     ),
            //                   );
            //                 })),
            //           );
            //         }),
            //   ),
            // ),

            // SizedBox(height: 20.h),

            // Search Bar
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 25.w),
            //   child: Container(
            //     height: 45.h,
            //     decoration: BoxDecoration(
            //       color: isDarkMode ? lightBlackColor2 : greyColor4,
            //       borderRadius: BorderRadius.circular(12.r),
            //     ),
            //     child: TextField(
            //       cursorColor: isDarkMode ? lightGreenColor : orange3,
            //       decoration: InputDecoration(
            //         hintText: 'Search',
            //         hintStyle: GoogleFonts.urbanist(
            //             fontSize: 18.sp,
            //             fontWeight: FontWeight.w400,
            //             color: isDarkMode ? grey5 : grey2),
            //         suffixIcon: SizedBox(
            //             height: 20.h,
            //             width: 20.w,
            //             child: Center(
            //                 child: SvgPicture.asset(
            //               "assets/icons/filter.svg",
            //               height: 20.h,
            //               width: 20.w,
            //               colorFilter: ColorFilter.mode(
            //                   isDarkMode ? lightGreenColor : orange3,
            //                   BlendMode.srcIn),
            //             ))),
            //         prefixIcon: SizedBox(
            //             height: 20.h,
            //             width: 20.w,
            //             child: Center(
            //                 child: SvgPicture.asset("assets/icons/search2.svg",
            //                     colorFilter: ColorFilter.mode(
            //                         isDarkMode ? grey5 : grey2,
            //                         BlendMode.srcIn),
            //                     height: 20.h,
            //                     width: 20.w))),
            //         border: InputBorder.none,
            //         contentPadding: EdgeInsets.only(top: 6.h),
            //       ),
            //     ),
            //   ),
            // ),

            // SizedBox(height: 20.h),

            // FAQs
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.faqs.length,
                  itemBuilder: (context, index) {
                    var faq = controller.faqs[index];
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.circular(20.r), // Apply rounded borders
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15.h),
                        decoration: BoxDecoration(
                          color: isDarkMode ? lightBlackColor2 : whiteColor,
                          borderRadius: BorderRadius.circular(
                              20.r), // Ensure rounded corners
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 80.r,
                              color: lightblackColor.withValues(alpha: 0.05),
                            )
                          ],
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            backgroundColor:
                                isDarkMode ? lightBlackColor2 : whiteColor,
                            collapsedBackgroundColor:
                                isDarkMode ? lightBlackColor2 : whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.r), // Ensure border rounding
                            ),
                            collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.r), // Ensure border rounding
                            ),
                            trailing: Obx(() => SizedBox(
                                  height: 15.h,
                                  width: 15.w,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      controller.expandedIndex.value == index
                                          ? "assets/icons/diamond.svg"
                                          : "assets/icons/diamond.svg",
                                      height: 20.h,
                                      width: 20.w,
                                      colorFilter: ColorFilter.mode(
                                          isDarkMode
                                              ? lightGreenColor
                                              : orange3,
                                          BlendMode.srcIn),
                                    ),
                                  ),
                                )),
                            onExpansionChanged: (isExpanded) {
                              controller.expandedIndex.value =
                                  isExpanded ? index : -1;
                            },
                            title: Text(
                              faq['question']!,
                              style: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode ? whiteColor : blackColor2,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: isDarkMode
                                            ? lightBlackColor
                                            : lightBlack,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Text(
                                      faq['answer']!,
                                      style: GoogleFonts.urbanist(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: isDarkMode
                                            ? greyColor
                                            : darkGreyColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
