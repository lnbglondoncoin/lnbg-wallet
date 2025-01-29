import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class CustomEdgeContainer extends StatelessWidget {
  final Widget child;

  const CustomEdgeContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // The main container where the child widget is placed
          SizedBox(
            width: 300.w,
            height: 300.h,
            child: child,
          ),

          // Top-left corner
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 50,
              height: 5,
              color: orange3,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 5,
              height: 50,
              color: orange3,
            ),
          ),

          // Top-right corner
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 50,
              height: 5,
              color: orange3,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 5,
              height: 50,
              color: orange3,
            ),
          ),

          // Bottom-left corner
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 50,
              height: 5,
              color: orange3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 5,
              height: 50,
              color: orange3,
            ),
          ),

          // Bottom-right corner
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 50,
              height: 5,
              color: orange3,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 5,
              height: 50,
              color: orange3,
            ),
          ),
        ],
      ),
    );
  }
}
