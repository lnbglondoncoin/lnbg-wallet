import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
     var theme = Theme.of(context);
    var textTheme = theme.textTheme;
     bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
       backgroundColor: theme.scaffoldBackgroundColor,
      // backgroundColor: whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 50.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
           Image.asset(
              isDarkMode
                  ? "assets/images/logodark.png" // Dark theme image
                  : "assets/images/onboarding.png",  // Light theme image
              height: 334.h,
              width: double.infinity,
            ),
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
        ),
      ),
    );
  }
}
