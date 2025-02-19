import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    final savedTheme = _storage.read('themeMode');
    themeMode.value = savedTheme == 'dark'
        ? ThemeMode.dark
        : savedTheme == 'light'
            ? ThemeMode.light
            : ThemeMode.system;
    super.onInit();
  }

  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    Get.changeThemeMode(themeMode.value);
    _storage.write(
        'themeMode',
        themeMode.value == ThemeMode.dark
            ? 'dark'
            : themeMode.value == ThemeMode.light
                ? 'light'
                : 'system');
  }

  void setSystemTheme() {
    themeMode.value = ThemeMode.system;
    Get.changeThemeMode(ThemeMode.system);
    _storage.write('themeMode', 'system');
  }
}
