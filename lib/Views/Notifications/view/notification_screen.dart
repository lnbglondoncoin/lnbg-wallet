import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/Notifications/controller/notification_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';

class NotificationScreen extends StatelessWidget {
   NotificationScreen({super.key});
final NotificationController controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
            appBar:
              CustomAppBar(title: "Notifications", iconPath: 'assets/icons/msg.svg',),
            
body: Obx(() {
        return 
        controller.notifications.isEmpty?
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return Container(
             
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
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
                        backgroundColor: Colors.grey[200],
                        backgroundImage: AssetImage(notification.iconPath),
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
                                color: blackColor2,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              notification.dateTime,
                              style: GoogleFonts.urbanist(
                                fontSize: 14.sp,
                                color: greyColor3,
                              fontWeight: FontWeight.w500 
                              ),
                            ),
                          
                          ],
                        ),
                      ),
                      if (notification.isNew)
                        Container(
                          width: 41.w,
                          height: 24.h,
                        
                          decoration: BoxDecoration(
                            color: orange4,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              "New",
                              style: GoogleFonts.poppins(
                                fontSize: 10.sp,
                                color: whiteColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
               
               SizedBox(height: 10.h,), 
                Text(
                
                              notification.description,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black54,
                              ),
                            ),
                ],
              ),
            );
          },
        ):
        Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60.h,),
              Center(child: Image.asset("assets/images/not.png",height: 300.h,width: 300.w,)),
              SizedBox(height: 40.h,),
              Text("Empty",style: GoogleFonts.urbanist(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: blackColor2
              ),),
              Text("You don't have any notifications at this time",style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: blackColor2
              ),) 
            ],
          ),
        );
      }),
    
    );
  }
}