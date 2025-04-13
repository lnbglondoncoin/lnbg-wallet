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
var isSearching=false.obs;
Future<void> fetchSearchData(String query, String address) async {
  // Clear previous search results before fetching new ones
  searchResult.value = [];
  isSearching.value = true;

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
fetchHistoryOfAnAddress(address);
      print("Parsed tokens: $tokens");
    } else {
      Get.snackbar("Error", "Failed to fetch data: ${response.statusCode}");
    }
  } catch (e) {
     isSearching.value = false;
    Get.snackbar("Error", "Something went wrong: $e");
    print("fetchSearchData: $e");
  } finally {
    // Ensure loading state is set to false once the data is fetched or if an error occurs
    isSearching.value = false;
  }


  
}



  var historyResults = <TokenData>[].obs;
Future<void> fetchHistoryOfAnAddress(String address) async {
  isLoading.value = true;

  final url =
      "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/browser/history/$address";

  print("Fetching from: $url");

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        final List<TokenData> tokens = decoded.map((item) {
          final tokenMap = item as Map<String, dynamic>;
          final tokenName = tokenMap["name"] ?? "";
          return TokenData.fromJson(tokenName, tokenMap);
        }).toList();

        historyResults.value = tokens;
        print("Parsed tokens: $tokens");
      } else {
        // Handle the case where the response is not a list (e.g., empty or error message)
        print("API returned non-list response: $decoded");
        historyResults.clear();
      }
    } else {
      Get.snackbar("Error", "Failed to fetch data: ${response.statusCode}");
    }
  } catch (e) {
    Get.snackbar("Error", "Something went wrong: $e");
    print("fetchHistoryOfAnAddress: $e");
  } finally {
    isLoading.value = false;
  }
}

 Future<void> clearHistory() async {
    try {
      isLoading.value = true;
      final url = Uri.parse(
          'http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/browser/history/${walletCreatingController.wallwtAddress.value}/clear');
      
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        historyResults.clear(); // clear local history
        Get.back(); // close bottom sheet
        Get.snackbar("Success", "Search history cleared successfully");
      } else {
        Get.snackbar("Error", "Failed to clear history: ${response.statusCode}");
      }
    } catch (e) {
        isLoading.value = false;
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
