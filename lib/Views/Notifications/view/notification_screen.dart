import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Notifications/controller/notification_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final NotificationController controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: const CustomAppBar(
        isSuffix: true,
        title: "Notifications",
        iconPath: 'assets/icons/msg.svg',
      ),
      body: Obx(() {
        return controller.notifications.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) {
                  final notification = controller.notifications[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: isDarkMode ? lightBlackColor3 : whiteColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 24.r,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage(notification.iconPath),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notification.title,
                                      style: GoogleFonts.urbanist(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        color: isDarkMode
                                            ? whiteColor
                                            : blackColor2,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      notification.dateTime,
                                      style: GoogleFonts.urbanist(
                                          fontSize: 14.sp,
                                          color: isDarkMode
                                              ? greyColor.withOpacity(0.5)
                                              : greyColor3,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              if (notification.isNew)
                                Container(
                                  width: 41.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    color:
                                        isDarkMode ? lightGreenColor : orange4,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "New",
                                      style: GoogleFonts.urbanist(
                                        fontSize: 10.sp,
                                        color: isDarkMode
                                            ? whiteColor
                                            : whiteColor,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            notification.description,
                            style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: isDarkMode
                                  ? whiteColor.withOpacity(0.7)
                                  : blackColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Center(
                        child: Image.asset(
                      isDarkMode
                          ? "assets/images/not2.png"
                          : "assets/images/not.png",
                      height: 300.h,
                      width: 300.w,
                    )),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "Empty",
                      style: GoogleFonts.urbanist(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? whiteColor : blackColor2),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "You don't have any notifications at this time",
                      style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: isDarkMode ? whiteColor : blackColor2),
                    )
                  ],
                ),
              );
      }),
    );
  }
}
