import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/history_item_model.dart';
import 'package:lnbg_crypto_wallet_app/Models/crypto_item_model.dart';

class BrowseController extends GetxController {
  var isAmountEmpty = true.obs;
  TextEditingController searchController = TextEditingController();
  void updateAmount() {
    isAmountEmpty.value = searchController.text.isEmpty;
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

  var historyList = <HistoryItem>[
    HistoryItem(
        name: "Pancake Swap",
        description: "PancakeSwap has the m...",
        imagePath: "assets/images/pancake.png"),
    HistoryItem(
        name: "ApeCoin",
        description: "The live ApeCoin...",
        imagePath: "assets/images/apecoin.png"),
    HistoryItem(
        name: "DAI",
        description: "We update our DAI to...",
        imagePath: "assets/images/dai.png"),
    HistoryItem(
        name: "Synthetix",
        description: "Capture the j...",
        imagePath: "assets/images/synthetix.png"),
    HistoryItem(
        name: "Tether USDT",
        description: "Tether, is an asset-backe...",
        imagePath: "assets/images/tether.png"),
    HistoryItem(
        name: "Tron TRX",
        description: "TRON is a de...",
        imagePath: "assets/images/tron.png"),
  ].obs;
}
