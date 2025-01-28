import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lnbg_crypto_wallet_app/Views/BottomNavigationBar/view/bottom_nav_bar.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Splash/controller/splash_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Splash/view/splash_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';


void main() {
 // Get.put(SplashController());
  Get.put(WalletCreatingController());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Moqtanayati',
          // home: SplashScreen(),
            home: BottomNavBar(),
        );
      },
    );
  }
}
