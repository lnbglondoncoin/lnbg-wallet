import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/token_decimal_and_description_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/Transections/controller/transection_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenDetailsController extends GetxController{
  RxBool isSwitched1 = false.obs;
  RxBool isSwitched2 = true.obs;
 final transactionController = Get.put(TransactionController());
  final walletCreatingCotroller = Get.find<WalletCreatingController>();
  
  @override
  void onInit(){
  super.onInit();
transactionController. fetchTransactions(walletCreatingCotroller.wallwtAddress.value);
}
  void toggleSwitch1() {
    isSwitched1.value = !isSwitched1.value;
  }

}