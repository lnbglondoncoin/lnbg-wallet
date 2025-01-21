import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImportFromSeedController extends GetxController{
    var passController=TextEditingController();
  var confirmPasswordController=TextEditingController();
  var seedPhraseController=TextEditingController();


    GlobalKey<FormState> importSeedKey = GlobalKey();

   // Define two RxBool variables for the switches
  RxBool isSwitched1 = false.obs;
  RxBool isSwitched2 = true.obs;

  // Method to toggle the first switch
  void toggleSwitch1() {
    isSwitched1.value = !isSwitched1.value;
  }

  // Method to toggle the second switch
  void toggleSwitch2() {
    isSwitched2.value = !isSwitched2.value;
  }
   var isChecked = false.obs;

  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }

  import(){
     if (!importSeedKey.currentState!.validate()) {
      return;
    }
    else{
  
    }
  }
}