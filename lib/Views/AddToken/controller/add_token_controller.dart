import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';

class AddTokenController extends GetxController{
   var isAmountEmpty = true.obs; // Reactive variable to track if amount is empty
var ammountController = TextEditingController();
  // Listen to changes in the text field
  void updateAmount() {
    isAmountEmpty.value =
        ammountController.text.isEmpty; // Update based on controller value
  }

// Use a list of RxBool instead of a list of bool
  RxList<RxBool> switchStates = List.generate(tokenIconList.length, (index) => false.obs).obs;

  // Toggle method
  void toggleSwitch(int index) {
    switchStates[index].value = !switchStates[index].value;
  }
}