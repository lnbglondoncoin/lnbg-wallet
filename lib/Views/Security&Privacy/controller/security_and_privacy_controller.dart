import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Walkthroughs/view/walkthrough.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SecurityAndPrivacyController extends GetxController {
  var selectedlocTime = 'After 5 minutes'.tr.obs;
  var isLoading=false.obs;
  RxBool isBiometric = false.obs;
  RxBool isface = false.obs;
  RxBool isRemember = false.obs;
  RxBool isPrivacy = false.obs;
  RxBool isAutoDectNFT = false.obs;
  RxBool openSeaAPI = false.obs;
  RxBool phishingDetection = false.obs;
  RxBool incommingTransections = false.obs;
   GlobalKey<FormState> changePasswordKey = GlobalKey();
     var passController = TextEditingController();
  var confirmPasswordController = TextEditingController();
    final walletCreatingController = Get.find<WalletCreatingController>();
    @override
      void onInit(){
      super.onInit();
        loadSelectedTime();
        
    }
    // var rememberme=false.obs;
     void setSelectedTime(String time) async {
    selectedlocTime.value = time;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auto_lock_time', time);
  }

  void loadSelectedTime() async {
    final prefs = await SharedPreferences.getInstance();
    String? time = prefs.getString('auto_lock_time');
    if (time != null) {
      selectedlocTime.value = time.tr;
    }
  }

    Future<void> deleteWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
Get.offAllNamed(AppRoutes.walkThroughScreen);

  }
  
  
  Future<void> clearBrowserCookies() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('browser_cookies'); // Assuming cookies are stored under this key
      Get.snackbar('Success'.tr, 'Browser cookies cleared successfully.'.tr,
         // snackPosition: SnackPosition.BOTTOM
          );
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error'.tr, 'Failed to clear browser cookies.',
         // snackPosition: SnackPosition.BOTTOM
          );
    }
    finally{
      isLoading(false);
    }
  }

  Future<void> clearBrowserHistory() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('browser_history'); // Assuming history is stored under this key
      Get.snackbar('Success'.tr, 'Browser history cleared successfully.'.tr,
          //snackPosition: SnackPosition.BOTTOM
          );
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error'.tr, 'Failed to clear browser history.'.tr,
         // snackPosition: SnackPosition.BOTTOM
          );
    }
    finally{
      isLoading(false);
    }
  }
}
