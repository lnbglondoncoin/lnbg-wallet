import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Models/transection_model.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/more_coin_details.dart';
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
      print('Sending transaction data: ${jsonEncode(body)}');

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Check if response is plain text or JSON
        if (response.body.trim().startsWith('{')) {
          try {
            final responseData = json.decode(response.body);
            print("Response data: $responseData");
            //  await walletCreatingCotroller.fetchWalletData(walletAddress,false,false);
            // await fetchTransactions(walletAddress);
            Get.snackbar('Success', 'Transaction submitted successfully!');
           
          } catch (e) {
            print('Error parsing JSON response: $e');
            Get.snackbar('Success', 'Transaction saved successfully');
          }
        } else {
          // Handle plain text response
          print('Received plain text response: ${response.body}');
          Get.snackbar('Success', 'Transaction saved successfully');
        }
      } else {
        print('Error response: ${response.body}');
        Get.snackbar('Failed post', 'Error: ${response.statusCode}');
      }
    } catch (e) {
      isLoading(false);
      print('Exception occurred posting: $e');
      print('Request body that caused error: ${jsonEncode(body)}');
      Get.snackbar('Exception posting', e.toString());
    } finally {
      isLoading(false);
    }
  }


   RxList<TransactionModel> transactions = <TransactionModel>[].obs;
RxList<TransactionModel> sendTransactions = <TransactionModel>[].obs;
  RxList<TransactionModel> buyTransactions = <TransactionModel>[].obs;
  RxList<TransactionModel> receiveTransactions = <TransactionModel>[].obs;
  RxList<TransactionModel> swapTransactions = <TransactionModel>[].obs;
RxDouble avg1Hour = 0.0.obs;
RxDouble avg1Day = 0.0.obs;
RxDouble avg1Week = 0.0.obs;
RxDouble avg1Month = 0.0.obs;
RxDouble avg1Year = 0.0.obs;
RxDouble avgTotal = 0.0.obs;
 Future<void> fetchTransactions(String walletAddress) async {
    final url =
        "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/transactions/$walletAddress";
print(url);
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        print(response.body);
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
        Get.snackbar("Error submitting", "Failed to load transactions $walletAddress");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error submitting", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
void calculateAverageTransactionAmounts(String tokenName, String method, TokenData token,TransactionModel transection) {
 isLoading(true);
  DateTime now = DateTime.now();

  List<TransactionModel> filteredTxs = transactions.where((tx) =>
      tx.method.toLowerCase() == method.toLowerCase() &&
      tx.token.toLowerCase() == tokenName.toLowerCase()).toList();

  // Helper to get average for time range
  double _calculateAvg(DateTime cutoff) {
    final rangeTxs = filteredTxs.where((tx) {
      DateTime txTime = DateTime.tryParse(tx.time) ?? DateTime(1970);
      return txTime.isAfter(cutoff);
    }).toList();

    if (rangeTxs.isEmpty) return 0.0;
    double total = rangeTxs.fold(0.0, (sum, tx) => sum + tx.amount);
    return total / rangeTxs.length;
  }

  avg1Hour.value = _calculateAvg(now.subtract(Duration(hours: 1)));
  avg1Day.value = _calculateAvg(now.subtract(Duration(days: 1)));
  avg1Week.value = _calculateAvg(now.subtract(Duration(days: 7)));
  avg1Month.value = _calculateAvg(now.subtract(Duration(days: 30)));
  avg1Year.value = _calculateAvg(now.subtract(Duration(days: 365)));
  avgTotal.value=avg1Hour.value+avg1Day.value+avg1Week.value+avg1Month.value+avg1Year.value;
  print("values are:$avg1Hour $avg1Day $avg1Day $avg1Week $avg1Month $avg1Year");
  Get.toNamed(
  AppRoutes.moreCoinDetails,
  arguments: {
    'transection': transection,
    'token': token,
  },
);
  
}


}
