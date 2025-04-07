import 'dart:async';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Walkthroughs/view/walkthrough.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';

class SplashController extends GetxController {
  final walletCreatingController = Get.find<WalletCreatingController>();

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () async {
      if (walletCreatingController.privateKey == null) {
        Get.off(() => WalkThroughScreen());
      } else {
        walletCreatingController.isLoading.value =
            true; // Set loading before fetch
        await walletCreatingController
            .fetchWalletData(walletCreatingController.wallwtAddress.value,walletCreatingController.privateKey==null?true:false);
      }
    });
  }
}
