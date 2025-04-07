import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    bool isDarkMode = theme.brightness == Brightness.dark;
    return  SizedBox(
      height: 58.h, // Same height as your buttons
        width: double.infinity,
      child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return  LinearGradient(
                    colors: isDarkMode?[lightGreenColor, lightGreenColor2]:[primaryColor, lightPrimaryColor], // Gradient colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: SpinKitCircle(
                  color: Colors.white, // Set a neutral color for blending
                  size: 50.h,
                ),
              ),
    );
  }
}