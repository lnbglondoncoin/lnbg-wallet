import 'dart:async';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Views/LockApp/view/lock_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Walkthroughs/view/walkthrough.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final walletCreatingController = Get.find<WalletCreatingController>();
  var isAppLock=false.obs;
var privateKey="".obs;
  @override
  @override
void onInit() async {
  super.onInit();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  privateKey.value = prefs.getString('privateKey') ?? '';
  Get.log('Private key: ${privateKey.value}');
  startTimer();
}


  void startTimer() {
    Timer(const Duration(seconds: 3), () async {
     if(isAppLock.value){
      Get.offAll(()=>LockScreen());
     }
     else{
       if (privateKey.value == null ||privateKey.value==""||privateKey.value.isEmpty) {
        Get.off(() => WalkThroughScreen());
      } else {
        // walletCreatingController.isLoading.value =
        //     true; // Set loading before fetch
        await walletCreatingController.loadWaletData(walletCreatingController.isAccountImporting.value);
      }
     }
    });
  }
}
