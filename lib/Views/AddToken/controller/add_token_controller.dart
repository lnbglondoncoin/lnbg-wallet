import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:http/http.dart' as http;

class AddTokenController extends GetxController {
  var isLoading = false.obs;
  var isAmountEmpty = true.obs;
  TextEditingController searchController = TextEditingController();
  RxList<RxBool> switchStates = List.generate(0, (index) => false.obs).obs;
  final walletCreatingController = Get.find<WalletCreatingController>();
  // var tokenList = <String>[].obs;
  // var tokenIcons = <String>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Populate initial data
  
    switchStates.assignAll(List.generate(
        walletCreatingController.hundredTokenData.map((e) => e.name).toList().length,
        (index) => false.obs));
         // Listen to each switch state and update isAnySwitchOn accordingly
    for (var state in switchStates) {
      ever(state, (_) => checkIfAnySwitchIsOn());
    }
    // tokenList.assignAll(
    //     walletCreatingController.hundredTokenData.map((e) => e.name).toList());
    // tokenIcons.assignAll(
    //     walletCreatingController.hundredTokenData.map((e) => e.logoUrl).toList());
  }
 void checkIfAnySwitchIsOn() {
    isAnySwitchOn.value = switchStates.any((state) => state.value == true);
  }

  void updateAmount() {
    isAmountEmpty.value = searchController.text.isEmpty;
  }

  // void filterTokens(String query) {
  //   searchQuery.value = query;

  //   if (query.isEmpty) {
  //     tokenList.assignAll(
  //         walletCreatingController.hundredTokenData.map((e) => e.name).toList());
  //     tokenIcons.assignAll(
  //         walletCreatingController.hundredTokenData.map((e) => e.logoUrl).toList());
  //     switchStates.assignAll(List.generate(
  //         walletCreatingController.hundredTokenData.map((e) => e.name).toList().length,
  //         (index) => false.obs));
  //   } else {
  //     var filteredTokens = <String>[];
  //     var filteredIcons = <String>[];
  //     var filteredSwitchStates = <RxBool>[];

  //     for (int i = 0; i < walletCreatingController.hundredTokenData.length; i++) {
  //       if (walletCreatingController.hundredTokenData
  //           .map((e) => e.name)
  //           .toList()[i]
  //           .toLowerCase()
  //           .contains(query.toLowerCase())) {
  //         filteredTokens.add(walletCreatingController.hundredTokenData
  //             .map((e) => e.name)
  //             .toList()[i]);
  //         filteredIcons.add(walletCreatingController.hundredTokenData
  //             .map((e) => e.logoUrl)
  //             .toList()[i]);
  //         filteredSwitchStates.add(switchStates[i]);
  //       }
  //     }

  //     tokenList.assignAll(filteredTokens);
  //     tokenIcons.assignAll(filteredIcons);
  //     switchStates.assignAll(filteredSwitchStates);
  //   }
  // }
 /// NEW: observable to track if any switch is on
  var isAnySwitchOn = false.obs;
  var selectedNetwork = "Ethereum".obs;
  changeNetwork(value) {
    selectedNetwork.value = value;
  }
   final addressController = TextEditingController();
  final nameController = TextEditingController();
  final symbolController = TextEditingController();
  final decimalController = TextEditingController();

   String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Recipient address is required';
    } else if (!RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(value)) {
      return "Invalid Ethereum address format";
    }
    return null;
  }
  List selectedTokenNames = [].obs;
  Future<void> savePreferences() async {
    const String url =
        "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/preferences/save";

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "walletAddress": walletCreatingController.wallwtAddress.value,
          "selectedTokens": selectedTokenNames,
        }),
      );

      if (response.statusCode == 200) {
        print(walletCreatingController.wallwtAddress.value);
        await walletCreatingController
            .fetchPreferences(walletCreatingController.wallwtAddress.value,false,walletCreatingController.isAccountImporting.value);
        Get.snackbar("Success", "Preferences saved successfully!",
            snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar("Error", "Failed to save preferences: ${response.body}",
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong: $e",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }
}
