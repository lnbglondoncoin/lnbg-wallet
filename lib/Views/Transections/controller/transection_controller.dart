import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lnbg_crypto_wallet_app/Models/transection_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';

class TransactionController extends GetxController {
  var isLoading = false.obs;
  var walletCreatingCotroller=Get.find<WalletCreatingController>();
@override
  void onInit(){
  super.onInit();
fetchTransactions(walletCreatingCotroller.wallwtAddress.value);
}
  Future<void> postTransaction({
    required String walletAddress,
    required String hash,
    required String method,
    required String time,
    required String from,
    required String to,
    required double amount,
    required double fee,
    required String token,
    required String fromToken,
    required String toToken,
  }) async {
    final String apiUrl = 'http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/transactions';

    final Map<String, dynamic> body = {
      "walletAddress": walletAddress,
      "transaction": {
        "hash": hash,
        "method": method,
        "time": time,
        "from": from,
        "to": to,
        "amount": amount,
        "fee": fee,
        "token": token,
        "fromToken": fromToken,
        "toToken": toToken
      }
    };

    try {
      isLoading(true);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        Get.snackbar('Success', 'Transaction submitted successfully!');
        print("Response: $responseData");
      } else {
        print('Error: ${response.body}');
        Get.snackbar('Failed', 'Error: ${response.statusCode}');
      }
    } catch (e) {
      isLoading(false);
      print('Exception occurred: $e');
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading(false);
    }
  }


   RxList<TransactionModel> transactions = <TransactionModel>[].obs;
RxList<TransactionModel> sendTransactions = <TransactionModel>[].obs;
  RxList<TransactionModel> buyTransactions = <TransactionModel>[].obs;
  RxList<TransactionModel> receiveTransactions = <TransactionModel>[].obs;
  RxList<TransactionModel> swapTransactions = <TransactionModel>[].obs;

 Future<void> fetchTransactions(String walletAddress) async {
    final url =
        "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/transactions/$walletAddress";
print(url);
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        transactions.value =
            jsonData.map((e) => TransactionModel.fromJson(e)).toList();

        // Split into respective lists
        sendTransactions.value =
            transactions.where((tx) => tx.method == 'send').toList();
        buyTransactions.value =
            transactions.where((tx) => tx.method == 'buy').toList();
        receiveTransactions.value =
            transactions.where((tx) => tx.method == 'receive').toList();
        swapTransactions.value =
            transactions.where((tx) => tx.method == 'swap').toList();
      } else {
        Get.snackbar("Error", "Failed to load transactions");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
