import 'dart:async';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Views/BottomNavigationBar/view/bottom_nav_bar.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Walkthroughs/view/walkthrough.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';

class SplashController extends GetxController {
  final walletCreatingController=Get.find<WalletCreatingController>();
  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 6), () {
      if(walletCreatingController.privateKey==null){
             Get.off(() => WalkThroughScreen());
      }
      else{
 Get.offAll(() => const BottomNavBar());
      }
     
    });
  }
}
