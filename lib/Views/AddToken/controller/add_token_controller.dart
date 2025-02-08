import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
class AddTokenController extends GetxController {
  var isLoading = false.obs;
  var isAmountEmpty = true.obs;
  
  TextEditingController searchController = TextEditingController();

  RxList<RxBool> switchStates = List.generate(tokenIconList.length, (index) => false.obs).obs;

  void toggleSwitch(int index) {
    switchStates[index].value = !switchStates[index].value;
  }

  var tokenList = <String>[].obs;
  var tokenIcons = <String>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Populate initial data
    tokenList.assignAll(tokennameList);
    tokenIcons.assignAll(tokenIconList);
  }

  void updateAmount() {
    isAmountEmpty.value = searchController.text.isEmpty;
  }

  void filterTokens(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      tokenList.assignAll(tokennameList);
      tokenIcons.assignAll(tokenIconList);
      switchStates.assignAll(List.generate(tokennameList.length, (index) => false.obs));
    } else {
      var filteredTokens = <String>[];
      var filteredIcons = <String>[];
      var filteredSwitchStates = <RxBool>[];

      for (int i = 0; i < tokennameList.length; i++) {
        if (tokennameList[i].toLowerCase().contains(query.toLowerCase())) {
          filteredTokens.add(tokennameList[i]);
          filteredIcons.add(tokenIconList[i]);
          filteredSwitchStates.add(switchStates[i]);
        }
      }

      tokenList.assignAll(filteredTokens);
      tokenIcons.assignAll(filteredIcons);
      switchStates.assignAll(filteredSwitchStates);
    }
  }

  var selectedNetwork="Ethereum".obs;
  changeNetwork(value){
    selectedNetwork.value=value;
  }
}
