import 'package:get/get.dart';
import 'package:flutter/animation.dart';

class ShakeAnimationController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotationAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    rotationAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.15), weight: 1),  // Rotate to 15 degrees
      TweenSequenceItem(tween: Tween(begin: 0.15, end: 0.0), weight: 1),  // Back to original
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.15), weight: 1), // Rotate to -15 degrees
      TweenSequenceItem(tween: Tween(begin: -0.15, end: 0.0), weight: 1), // Back to original
    ]).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
  }

  void startShakeAnimation() {
    animationController.forward(from: 0.0);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
