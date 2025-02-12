import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lnbg_crypto_wallet_app/Constants/my_theme.dart';
import 'package:lnbg_crypto_wallet_app/Constants/theme_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/BottomNavigationBar/view/bottom_nav_bar.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Splash/controller/splash_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Splash/view/splash_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';

void main() async {
  // Get.put(SplashController());
  Get.put(WalletCreatingController());
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
       final ThemeController themeController = Get.put(ThemeController());

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Moqtanayati',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.lightTheme,
            themeMode: themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
             //home: SplashScreen(),
             home: BottomNavBar(),
          );
        },
      );
  }
}
