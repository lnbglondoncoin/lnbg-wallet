import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyController extends GetxController {
  var selectedCurrency = 'USD'.obs;
  var amountController = TextEditingController();
  var amount = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to text changes and update amount in real time
    amountController.addListener(() {
      amount.value = amountController.text;
    });
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}
