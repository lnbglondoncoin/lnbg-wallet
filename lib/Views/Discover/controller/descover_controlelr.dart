import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Models/crypto_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lnbg_crypto_wallet_app/Models/discover_token_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';

class DiscoverController extends GetxController {
 final Map<String, RxList<TokenData>> tokensByCategory = {};
  var searchQuery = ''.obs;
  TextEditingController searchController = TextEditingController();
var isLoading=false.obs;
   final walletCreatingController = Get.find<WalletCreatingController>();
 @override
void onInit() {
  super.onInit();
  isLoading(true); // Start loading before initiating all fetches

  Future.wait(categories.map((category) async {
    tokensByCategory[category] = <TokenData>[].obs;
    await fetchCategoryData(category,walletCreatingController.wallwtAddress.value); // wait for each fetch
  })).then((_) {
    isLoading(false); // All done!
  }).catchError((e) {
    isLoading(false);
    Get.snackbar("Error", e.toString());
  });
}
 
/// Filtered structure with category and tokens
  Map<String, List<TokenData>> get filteredCategoriesWithTokens {
    String query = searchQuery.value.toLowerCase();

    if (query.isEmpty) return tokensByCategory;

    Map<String, List<TokenData>> result = {};

    for (var category in categories) {
      final allTokens = tokensByCategory[category]!;

      // If category matches query, show full category with all tokens
      if (category.toLowerCase().contains(query)) {
        result[category] = allTokens;
      } else {
        // Otherwise, check for matching tokens in this category
        final matchingTokens = allTokens.where((token) =>
            token.name.toLowerCase().contains(query) ||
            token.symbol.toLowerCase().contains(query)).toList();

        if (matchingTokens.isNotEmpty) {
          result[category] = matchingTokens;
        }
      }
    }

    return result;
  
}


  // Future<void> fetchCategoryData(String category) async {
  //   try {
     
  //     final url = 'http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/discover/${Uri.encodeComponent(category)}';
  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       final List data = json.decode(response.body);
  //       tokensByCategory[category]!.assignAll(data.map((e) => TokenData.fromJson(category,e)).toList());
  //     } else {
  //       Get.snackbar("Error", "Failed to load ${category} data");
  //     }
  //   } catch (e) {
      
  //     Get.snackbar("Exception", e.toString());
  //   }
  //   finally{
     
  //   }
  // }
 Future<void> fetchCategoryData(String category, String walletAddress) async {
  try {
    final encodedCategory = Uri.encodeComponent(category);
    final encodedWalletAddress = Uri.encodeComponent(walletAddress);

    final url =
        'http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/discover/$encodedCategory?userAddress=$encodedWalletAddress';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      tokensByCategory[category]!.assignAll(
        data.map((e) => TokenData.fromJson(category, e)).toList(),
      );
    } else {
      Get.snackbar("Error", "Failed to load $category data");
    }
  } catch (e) {
    Get.snackbar("Exception", e.toString());
  }
}

   final List<String> categories = [
    "staking",
    "memes",
    "defi",
    "gaming",
    "metaverse"
  ].obs;  

  var tokenList = <TokenData>[].obs;
  void fetchAllTokensOfCategory(String category, String walletAddress) async {
  try {
    Get.log(category);
    isLoading(true);

    final encodedCategory = Uri.encodeComponent(category);
    final encodedWalletAddress = Uri.encodeComponent(walletAddress);

    final url =
        "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/discover/$encodedCategory/all?userAddress=$encodedWalletAddress";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      tokenList.value = data.map((e) => TokenData.fromJson(category, e)).toList();
    } else {
      Get.snackbar("Error", "Failed to fetch tokens");
    }
  } catch (e) {
    isLoading(false);
    Get.snackbar("Error", e.toString());
  } finally {
    isLoading(false);
  }
}

// void fetchAllTokensOfCategory(String category) async {
//     try {
//       Get.log(category);
//       isLoading(true);
//       final response = await http.get(Uri.parse("http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/discover/$category/all"));

//       if (response.statusCode == 200) {
//         List data = jsonDecode(response.body);
//         tokenList.value = data.map((e) => TokenData.fromJson(category,e)).toList();
//       } else {
//         Get.snackbar("Error", "Failed to fetch tokens");
//       }
//     } catch (e) {
//            isLoading(false);
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }

}
