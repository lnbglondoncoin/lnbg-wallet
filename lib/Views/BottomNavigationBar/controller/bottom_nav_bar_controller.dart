import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';

class BottomNavController extends GetxController {
   final walletCreatingController = Get.find<WalletCreatingController>();
 
@override
  void onInit(){
  super.onInit();
  
    if(walletCreatingController.hundredTokenData.isEmpty){
      walletCreatingController.fetchSlugs();
    }
}
  var currentIndex = 0.obs;
  void updateIndex(int index) {
    currentIndex.value = index;
  
  }
}
