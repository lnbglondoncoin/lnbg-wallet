import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Models/history_item_model.dart';
import 'package:lnbg_crypto_wallet_app/Models/crypto_item_model.dart';
import 'package:http/http.dart' as http;
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';

class BrowseController extends GetxController {
  var isAmountEmpty = true.obs;
  TextEditingController searchController = TextEditingController();
  final walletCreatingController = Get.find<WalletCreatingController>();
  @override
  void onInit(){
    super.onInit();
  fetchHistoryOfAnAddress(walletCreatingController.wallwtAddress.value);
    
  }
  void updateAmount() {
    isAmountEmpty.value = searchController.text.isEmpty;
        if (!isAmountEmpty.value) {
      
      fetchSearchData(searchController.text.trim(), walletCreatingController.wallwtAddress.value);
    }
    // else {
    //   searchResult.value = [];  // Clear results if query is empty
    // }

  }

  var cryptoList = <CryptoItem>[
    CryptoItem(name: "Ethereum", imagePath: "assets/icons/etg.png"),
    CryptoItem(name: "Solana", imagePath: "assets/icons/solana.png"),
    CryptoItem(name: "Polygon", imagePath: "assets/icons/polygon.png"),
    CryptoItem(name: "Shiba Inu", imagePath: "assets/icons/shiba.png"),
    CryptoItem(name: "Google", imagePath: "assets/icons/google.png"),
    CryptoItem(name: "Bitcoin", imagePath: "assets/icons/bitcoin.png"),
    CryptoItem(name: "Binance", imagePath: "assets/icons/binance.png"),
    CryptoItem(
        name: "Decentraland", imagePath: "assets/icons/decentraland.png"),
  ].obs;

  // var historyList = <HistoryItem>[
  //   HistoryItem(
  //       name: "Pancake Swap",
  //       description: "PancakeSwap has the m...",
  //       imagePath: "assets/images/pancake.png"),
  //   HistoryItem(
  //       name: "ApeCoin",
  //       description: "The live ApeCoin...",
  //       imagePath: "assets/images/apecoin.png"),
  //   HistoryItem(
  //       name: "DAI",
  //       description: "We update our DAI to...",
  //       imagePath: "assets/images/dai.png"),
  //   HistoryItem(
  //       name: "Synthetix",
  //       description: "Capture the j...",
  //       imagePath: "assets/images/synthetix.png"),
  //   HistoryItem(
  //       name: "Tether USDT",
  //       description: "Tether, is an asset-backe...",
  //       imagePath: "assets/images/tether.png"),
  //   HistoryItem(
  //       name: "Tron TRX",
  //       description: "TRON is a de...",
  //       imagePath: "assets/images/tron.png"),
  // ].obs;



  var searchResult = <TokenData>[].obs;
var isLoading = false.obs;
Future<void> fetchSearchData(String query, String address) async {
  // Clear previous search results before fetching new ones
  searchResult.value = [];
  isLoading.value = true;

  final url =
      "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/browser/search?query=$query&address=$address";

  print("Fetching from: $url");

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      print("Raw response: $data");

      final List<TokenData> tokens = data.map((item) {
        final tokenMap = item as Map<String, dynamic>;
        final tokenName = tokenMap["name"] ?? "";
        return TokenData.fromJson(tokenName, tokenMap);
      }).toList();

      // Set the searchResult to the new data
      searchResult.value = tokens;

      print("Parsed tokens: $tokens");
    } else {
      Get.snackbar("Error", "Failed to fetch data: ${response.statusCode}");
    }
  } catch (e) {
    Get.snackbar("Error", "Something went wrong: $e");
    print("Fetch error: $e");
  } finally {
    // Ensure loading state is set to false once the data is fetched or if an error occurs
    isLoading.value = false;
  }
}



  var historyResults = <TokenData>[].obs;
Future<void> fetchHistoryOfAnAddress(String address) async {
  // Clear previous search results before fetching new ones

  isLoading.value = true;

  final url =
      "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/browser/history/$address";

  print("Fetching from: $url");

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      print("Raw response: $data");

      final List<TokenData> tokens = data.map((item) {
        final tokenMap = item as Map<String, dynamic>;
        final tokenName = tokenMap["name"] ?? "";
        return TokenData.fromJson(tokenName, tokenMap);
      }).toList();

      // Set the searchResult to the new data
      historyResults.value = tokens;

      print("Parsed tokens: $tokens");
    } else {
      Get.snackbar("Error", "Failed to fetch data: ${response.statusCode}");
    }
  } catch (e) {
    Get.snackbar("Error", "Something went wrong: $e");
    print("Fetch error: $e");
  } finally {
    // Ensure loading state is set to false once the data is fetched or if an error occurs
    isLoading.value = false;
  }
}

}
