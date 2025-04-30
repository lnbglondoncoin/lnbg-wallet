import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/BottomNavigationBar/view/bottom_nav_bar.dart';
import 'package:lnbg_crypto_wallet_app/Views/LockApp/view/lock_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Splash/controller/splash_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Walkthroughs/view/walkthrough.dart';
import 'package:lnbg_crypto_wallet_app/Views/Security&Privacy/controller/security_and_privacy_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLockController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  String? _lastRoute;
  var isAuthenticated = false.obs;
  var isLoading = false.obs;
  Future<void> authenticate(BuildContext context) async {
    try {
      isLoading(true);
      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        isAuthenticated(true);
        Get.snackbar("Success", "Authenticated", );
        showPopup(context);
        unlockApp();
        isLoading(false);
      } else {
        Get.snackbar("Error", "Authentication Failed",
            backgroundColor: orange3);
        isLoading(false);
      }
    } on PlatformException catch (e) {
      isLoading(false);
      print(e);
    }
  }

  void showPopup(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
          backgroundColor: isDarkMode ? lightBlackColor2 : whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon: isDarkMode
              ? Image.asset(
                  "assets/images/suucess4.png",
                  height: 180.h,
                  width: 186.w,
                )
              : Image.asset(
                  "assets/images/success.png",
                  height: 180.h,
                  width: 186.w,
                ),
          title: Text(
            "Successful!",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp, fontWeight: FontWeight.w700, color: orange3),
          ),
          content: Text(
              textAlign: TextAlign.center,
              "Preparing...\nPlease wait a moment.",
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? whiteColor : blackColor2)),
          actions: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [primaryColor, lightPrimaryColor], // Gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: SpinKitCircle(
                color: Colors.white, // Set a neutral color for blending
                size: 50.h,
              ),
            ),
          ],
        );
      },
    );
  }

  final splashController = Get.find<SplashController>();
  GlobalKey<FormState> unlockAppKey = GlobalKey();
  var passController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  RxBool isSwitched2 = false.obs;
  final walletCreatingController = Get.find<WalletCreatingController>();
  Timer? _lockTimer;
 
  @override
  void onInit() {
    super.onInit();
    walletCreatingController.getPassword();

    startLockTimer(); // start when the controller initializes
  }

  void clearControllers() {
    passController.text = "";
    confirmPasswordController.text = "";
    isSwitched2.value = false;
     splashController.isAppLock.value = false;
     isAuthenticated.value=false;
       isLoading(false);
  }

 RxInt screenLockTimer = 5.obs;
  void startLockTimer() async {
  final prefs = await SharedPreferences.getInstance();
  String? timeTemp = prefs.getString('auto_lock_time');

  // Set default value if not set
  if (timeTemp == null) {
    timeTemp = "After 5 minutes";
    await prefs.setString('auto_lock_time', timeTemp);
  }

  // Map the string value to an integer
  int time = timeTemp == "After 5 minutes"
      ? 5
      : timeTemp == "After 10 minutes"
          ? 10
          : 15; // Default to 15 minutes if no match

  screenLockTimer.value = time; // Assign the parsed integer value
  final privateKey = prefs.getString('privateKey') ?? '';

  Get.log("Auto-lock time set to: $time minutes");

  stopLockTimer(); // Clear any previous timer

  _lockTimer = Timer.periodic(Duration(minutes: screenLockTimer.value), (timer) {
    if (privateKey.isNotEmpty) {
      _lockApp();
    }
  });
}


  void _lockApp() {
    splashController.isAppLock.value = true;
    _lastRoute = Get.currentRoute;
    Get.offAll(() => LockScreen()); // navigate to lock screen
  }

  void unlockApp() async {
    if (isAuthenticated.value) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final privateKey = prefs.getString('privateKey') ?? '';
      if (privateKey != null && privateKey != "" && privateKey.isNotEmpty&&walletCreatingController.importngOrCreatingprocessCompletion.value) {
        Get.offAll(() => BottomNavBar());
       
        clearControllers();
      } else {
        Get.off(() => WalkThroughScreen());
       
        clearControllers();
      }
    } else if (!unlockAppKey.currentState!.validate()) {
      return;
    } else if (walletCreatingController.password == passController.text) {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final privateKey = prefs.getString('privateKey') ?? '';
      if (privateKey != null && privateKey != "" && privateKey.isNotEmpty) {
       if(walletCreatingController.tokenData.isNotEmpty&&walletCreatingController.hundredTokenData.isNotEmpty&&walletCreatingController.importngOrCreatingprocessCompletion.value){
         Get.offAll(() => BottomNavBar());
        
        
       }
       else{
        walletCreatingController.loadWaletData(true,);
       }
      
        
        clearControllers();
      } else {
        isLoading(true);
        Get.off(() => WalkThroughScreen());
      
     
        clearControllers();
      }
    } else if (walletCreatingController.password != passController.text) {
      Get.snackbar("Error", "Incorrect Password");
      clearControllers();
    } else {
      clearControllers();
    }
  }

  void stopLockTimer() {
    _lockTimer?.cancel();
  }

  void resetLockTimer() {
    startLockTimer(); // restart the timer after activity
  }
}
