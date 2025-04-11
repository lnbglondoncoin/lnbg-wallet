import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityAndPrivacyController extends GetxController {
  var selectedlocTime = 'After 5 minutes'.obs;
  
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
     void setSelectedTime(String time) async {
    selectedlocTime.value = time;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auto_lock_time', time);
  }

  void loadSelectedTime() async {
    final prefs = await SharedPreferences.getInstance();
    String? time = prefs.getString('auto_lock_time');
    if (time != null) {
      selectedlocTime.value = time;
    }
  }
}
