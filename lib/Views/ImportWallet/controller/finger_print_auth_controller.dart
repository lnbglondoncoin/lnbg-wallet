import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrintScanController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  var supportState = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkDeviceSupport();
  }

  void checkDeviceSupport() async {
    supportState.value = await auth.isDeviceSupported();
  }

  // Future<void> getAvailableBiometrics() async {

  //   List<BiometricType> availableBiometrics =
  //       await auth.getAvailableBiometrics();

  // }

  Future<void> authenticate(BuildContext context) async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        Get.snackbar("Success", "Authenticated", backgroundColor: orange3);
        showPopup(context);
      } else {
        Get.snackbar("Error", "Authentication Failed",
            backgroundColor: orange3);
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void showPopup(BuildContext context) {
         var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
          backgroundColor:isDarkMode?lightBlackColor2:whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon:isDarkMode? Image.asset(
            "assets/images/suucess4.png",
            height: 180.h,
            width: 186.w,
          ): Image.asset(
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
                  color: isDarkMode?whiteColor:blackColor2)),
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
}
