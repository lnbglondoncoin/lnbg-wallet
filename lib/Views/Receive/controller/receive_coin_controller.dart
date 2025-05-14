import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ReceiveCoinController extends GetxController {
  var amountController = TextEditingController();
  void copyAddress(String walletAddress) {
    Clipboard.setData(ClipboardData(text: walletAddress));
    Get.snackbar("Copied".tr, "Wallet address copied to clipboard".tr);
  }
}
