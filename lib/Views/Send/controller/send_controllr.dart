import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendController extends GetxController {
  var ammountController = TextEditingController();
    var addressController = TextEditingController();
    var recipientAddressController = TextEditingController();
  var isAmountEmpty = true.obs; // Reactive variable to track if amount is empty

  // Listen to changes in the text field
  void updateAmount() {
    isAmountEmpty.value = ammountController.text.isEmpty; // Update based on controller value
  }
  var enableTextFeild=  false.obs;
  var isEditClicked=false.obs;


  var selectedSpeed=0.obs;
  void changeSelectedSpeed(index){
    selectedSpeed.value=index;
  }

}
