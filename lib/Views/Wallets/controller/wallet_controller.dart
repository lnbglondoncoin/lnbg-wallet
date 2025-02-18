import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class WalletController extends GetxController{
   List walletIcons=[
    "assets/icons/wallet1.png",
     "assets/icons/wallet2.png",
      "assets/icons/wallet3.png"].obs;

      List walletTitles=[
    "AndrewAinsley",
     "AndrewAinsley",
      "Andrew Metacoin"].obs;

       List walletSubTitles=[
    "Multi-Coin Wallet",
     "Multi-Coin Wallet",
      "Imported Wallet"].obs;

   var selectedWallwt=0.obs;
   changeSelectedWallet(index){
    selectedWallwt.value=index;
   }

     void deleteWallet(int index) {
    if (index >= 0 && index < walletIcons.length) {
      walletIcons.removeAt(index);
      walletTitles.removeAt(index);
      walletSubTitles.removeAt(index);
    }
  }
}