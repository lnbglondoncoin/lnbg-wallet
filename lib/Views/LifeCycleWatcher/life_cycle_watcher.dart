import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/LockApp/view/lock_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Security&Privacy/controller/security_and_privacy_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LifecycleWatcher with WidgetsBindingObserver {
  static final LifecycleWatcher _instance = LifecycleWatcher._internal();
  bool shouldShowLock = false;
   final securityController = Get.find<SecurityAndPrivacyController>();
  final walletCreatingController=Get.find<WalletCreatingController>();
  factory LifecycleWatcher() => _instance;

  LifecycleWatcher._internal();

  void init() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)async {
     final prefs = await SharedPreferences.getInstance();
    
      final privateKey = prefs.getString('privateKey') ?? '';
    if (state == AppLifecycleState.paused) {
      shouldShowLock = true;
    } else if (state == AppLifecycleState.resumed && shouldShowLock) {
      shouldShowLock = false;
      if(privateKey != null && privateKey != "" && privateKey.isNotEmpty&&walletCreatingController.importngOrCreatingprocessCompletion.value&&securityController.isRemember.value==false){
         Get.offAllNamed(AppRoutes.lockScreen);
         
      }
     
    }
  }
}
