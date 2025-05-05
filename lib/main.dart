import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lnbg_crypto_wallet_app/Constants/my_theme.dart';
import 'package:lnbg_crypto_wallet_app/Constants/theme_controller.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/LifeCycleWatcher/life_cycle_watcher.dart';
import 'package:lnbg_crypto_wallet_app/Views/LockApp/controller/lock_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Splash/controller/splash_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Splash/view/splash_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Security&Privacy/controller/security_and_privacy_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Transections/controller/transection_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(WalletCreatingController());
 // Get.put(TransactionController());
   Get.put(SecurityAndPrivacyController());
  Get.put(SplashController());

  await GetStorage.init();
   Get.put(AppLockController()); // 🔒 To lock app automatically
   LifecycleWatcher().init(); // 🔒 Initialize lifecycle observer
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    LifecycleWatcher().dispose(); // 👈 Dispose the observer here
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
// Set the status bar style based on the theme mode (light or dark)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Make the status bar transparent (optional)
      statusBarIconBrightness: themeController.themeMode.value == ThemeMode.dark 
        ? Brightness.light 
        : Brightness.dark, // Light icons for dark mode, dark icons for light mode
      systemNavigationBarColor: Colors.black, // Optional: set system navigation bar color
      systemNavigationBarIconBrightness: Brightness.light, // Optional: set nav bar icons to light
    ));
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          builder: (context, widget) {
            // This line ensures that the app doesn't scale with the phone's font size settings
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: widget!,
              
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'LNBG',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode.value,
          initialRoute: AppRoutes.splashScreen,
          // home: AppRoutes.splashScreen,
          getPages: AppRoutes.routes, // ✅ THIS LINE IS ESSENTIAL
          //home: BottomNavBar(),
        );
      },
    );
  }
}
