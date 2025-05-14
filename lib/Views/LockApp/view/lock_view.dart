import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/LockApp/view/unlock_view.dart';

class LockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'App Locked'.tr,
                style: TextStyle(color: Colors.white, fontSize: 30.sp),
              ),
          
              SizedBox(height: 20.h,),
              GestureDetector(
                onTap: (){
                  Get.offAllNamed(AppRoutes.unlockView);
                },
                child: Text("Click to unlock".tr,
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),),
              ),
              SizedBox(height: 10.h,),
              Text(
                textAlign: TextAlign.center,
                "You can change auto lock app time in settings=>Security and Privacy in(Auto Lock section)".tr,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),),
            ],
          ),
        ),
      ),
    );
  }
}
