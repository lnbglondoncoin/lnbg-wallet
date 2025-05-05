// WalkThroughController using GetX
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Walkthroughs/view/wallet_setup.dart';

class WalkThroughController extends GetxController {
  final PageController pageController = PageController();
  RxInt currentIndex = 0.obs;

  final List<Map<String, String>> walkthroughData = [
    {
      "image": coin1,
      "title": "The Best Crypto Wallet App",
      "description":
          "Effortlessly manage, stake, and grow your digital assets with unmatched security, innovation, and trust."
    },
    {
      "image": coin2,
      "title": "Your Security is Our Top Priority",
      "description":
          "We ensure your digital assets are protected with advanced security measures and innovative solutions."
    },
    {
      "image": coin3,
      "title": "Crypto Transactions Now is Easier",
      "description":
          "Experience seamless, secure, and hassle-free crypto transactions with LNBG Coin, designed to simplify your digital finance journey."
    }
  ];

  void nextPage() {
    if (currentIndex.value < walkthroughData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentIndex.value++;
    } else {
      Get.toNamed(AppRoutes.walletSetUpScreen);
   
    }
  }
}
