import 'package:flutter/material.dart';
import 'package:get/get.dart';


class QrScanproductionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var scanQr = false.obs;
  late AnimationController animationController;
  late Animation<double> animation;
  var isMovingDown = true.obs;

  @override
  void onInit() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isMovingDown.value = false;
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          isMovingDown.value = true;
          animationController.forward();
        }
      });
    super.onInit();
  }

  void startScanning() {
    scanQr.value = true;
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

