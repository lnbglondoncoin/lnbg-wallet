import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Views/LockApp/view/lock_view.dart';

class LifecycleWatcher with WidgetsBindingObserver {
  static final LifecycleWatcher _instance = LifecycleWatcher._internal();
  bool shouldShowLock = false;

  factory LifecycleWatcher() => _instance;

  LifecycleWatcher._internal();

  void init() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      shouldShowLock = true;
    } else if (state == AppLifecycleState.resumed && shouldShowLock) {
      shouldShowLock = false;
      Get.offAll(() =>  LockScreen());
    }
  }
}
