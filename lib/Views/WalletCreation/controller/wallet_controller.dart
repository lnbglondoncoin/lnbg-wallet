import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/secure_vallet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';

class StepController extends GetxController {
  @override
  void onInit(){
    super.onInit();
    
  }
  var currentIndex = 0.obs;
  var passController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  void updateIndex(int index) {
    if (index >= 0 && index < 3) {
      currentIndex.value = index;
    }
  }

  void decreseIndexValue(int index) {
    if (index >= 0 && index < 3) {
      index == 0 ? currentIndex.value = index : currentIndex.value = index - 1;
    }
  }

  GlobalKey<FormState> passwordKey = GlobalKey();

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

  createPassword() {
    if (!passwordKey.currentState!.validate()) {
      return;
    } else {
      updateIndex(1);
      Get.to(() => SecureWalletScreen());
    }
  }

  var selectedSeeds = [].obs;
  addSeeds(value) {
    if (selectedSeeds.contains(value)) {
      selectedSeeds.remove(value);
    } else {
      selectedSeeds.add(value);
    }
  }

  var selecetedIndexs = [].obs;
  addToSelectedIndex(index) {
    if (selecetedIndexs.contains(index)) {
      selecetedIndexs.remove(index);
    } else {
      selecetedIndexs.add(index);
    }
  }

  var items = [
    'material',
    'space',
    'wristn',
    'bench',
    'option',
    'payment',
    'skate',
    'bomb',
    'harbor',
    'hint',
    'peart',
    'maze'
  ].obs;




}
