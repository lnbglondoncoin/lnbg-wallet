import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendController extends GetxController {
  var ammountController = TextEditingController();
  var isAmountEmpty = true.obs; // Reactive variable to track if amount is empty

  // Listen to changes in the text field
  void updateAmount() {
    isAmountEmpty.value = ammountController.text.isEmpty; // Update based on controller value
  }
}
