import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SwapController extends GetxController {
  final walletCreatingCotroller = Get.find<WalletCreatingController>();
  var balanceController = TextEditingController();

  // 1inch API configuration
  static const String chainId = '1'; // Ethereum mainnet
  static const String oneInchUrl = 'https://api.1inch.io/v5.0';
  // Get API key from env
  String get oneInchApiKey => dotenv.get('ONE_INCH_API_KEY', fallback: '');

  // Existing variables
  RxDouble usdAmount = 0.0.obs;
  RxDouble cryptoAmount = 0.0.obs;
  RxDouble usdAmount2nd = 0.0.obs;
  RxDouble cryptoAmount2nd = 0.0.obs;

  // New variables for 1inch
  var isLoading = false.obs;
  final currentQuote = RxMap<String, dynamic>({});
  Timer? quoteTimer;
  var swapRate = 0.0.obs;
  var networkFee = 0.0.obs;

  // Add a computed property to check if swap is possible
  bool get canSwap => 
    !isLoading.value && 
    currentQuote.isNotEmpty && 
    cryptoAmount.value > 0;

  @override
  void onInit() {
    super.onInit();
    if (walletCreatingCotroller.tokenData.isNotEmpty) {
      firstToken.value = walletCreatingCotroller.tokenData[0];
      secondToken.value = walletCreatingCotroller.tokenData[1];
    }
  }

  // Update amount with 1inch quote
  void updateAmount(String value, double coinPrice) {
    if (value.isEmpty) {
      usdAmount.value = 0.0;
      cryptoAmount.value = 0.0;
      usdAmount2nd.value = 0.0;
      cryptoAmount2nd.value = 0.0;
      return;
    }

    try {
      usdAmount.value = double.tryParse(value) ?? 0.0;
      cryptoAmount.value = usdAmount.value / coinPrice;
      
      if (cryptoAmount.value > 0) {
        Get.log(secondToken.value.contractAddress);
        // getSwapQuote();
      }
    } catch (e) {
      print('Error in updateAmount: $e');
    }
  }

  // Get real-time quote from 1inch
  Future<void> getSwapQuote() async {
    if (cryptoAmount.value <= 0) return;

    try {
      isLoading(true);

      // Format the amount with proper decimals (usually 18 for most tokens)
      String amount = (cryptoAmount.value * 1e18).toStringAsFixed(0);
      
      final url = Uri.parse(
        '$oneInchUrl/$chainId/quote?'
        'fromTokenAddress=${firstToken.value.contractAddress}'
        '&toTokenAddress=${secondToken.value.contractAddress}'
        '&amount=$amount'
      );

      print('Request URL: $url'); // Debug print

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $oneInchApiKey', // Add API key to headers
        },
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final quote = json.decode(response.body);
        currentQuote.value = quote;

        // Calculate the exchange rate
        double fromAmount = double.parse(quote['fromTokenAmount']) / 1e18;
        double toAmount = double.parse(quote['toTokenAmount']) / 1e18;
        
        swapRate.value = toAmount / fromAmount;
        
        // Update second token amounts
        cryptoAmount2nd.value = toAmount;
        usdAmount2nd.value = toAmount * secondToken.value.priceInUsd;

        updateAmount2nd();
      } else {
        print('Error response: ${response.body}');
        throw Exception('Failed to get quote: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getSwapQuote: $e');
      Get.snackbar(
        'Error',
        'Failed to get quote. Please try again.',
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // Start real-time quote updates
  void startQuoteUpdates() {
    quoteTimer?.cancel();
    quoteTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (cryptoAmount.value > 0) {
        getSwapQuote();
      }
    });
  }

  // Execute swap
  Future<void> executeSwap() async {
    try {
      isLoading(true);
      
      if (currentQuote.isEmpty) {
        throw Exception('No valid quote found');
      }

      final response = await http.post(
        Uri.parse('$oneInchUrl/$chainId/transactions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $oneInchApiKey', // Add API key to headers
        },
        body: json.encode({
          'quoteId': currentQuote['id'],
          'walletAddress': walletCreatingCotroller.wallwtAddress.value,
          'baseCurrencyAmount': cryptoAmount.value,
          'quoteCurrencyAmount': cryptoAmount2nd.value,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Swap executed successfully!');
        resetSwap();
        balanceController.clear();
      } else {
        throw Exception('Swap failed: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Swap failed: $e');
    } finally {
      isLoading(false);
    }
  }

  // Reset swap state
  void resetSwap() {
    usdAmount.value = 0.0;
    cryptoAmount.value = 0.0;
    usdAmount2nd.value = 0.0;
    cryptoAmount2nd.value = 0.0;
    currentQuote.clear();
    quoteTimer?.cancel();
  }

  @override
  void onClose() {
    quoteTimer?.cancel();
    balanceController.dispose();
    super.onClose();
  }

  // Two observable TokenData variables
  var firstToken = TokenData(
    symbol: "",
    logoUrl: "",
    contractAddress: "",
    name: "",
    balance: 0.0,
    balanceInUsd: 0.0,
    priceInUsd: 0.0,
    trend: "",
    trendPercentage: 0.0,
  ).obs;

  var secondToken = TokenData(
    symbol: "",
    logoUrl: "",
    contractAddress: "",
    name: "",
    balance: 0.0,
    balanceInUsd: 0.0,
    priceInUsd: 0.0,
    trend: "",
    trendPercentage: 0.0,
  ).obs;

  // Function to update tokens
  void updateFirstToken(TokenData token) {
    firstToken.value = token;
    if (usdAmount.value > 0) {
      getSwapQuote();
    }
    Get.back();
  }

  void updateSecondToken(TokenData token) {
    secondToken.value = token;
    if (usdAmount.value > 0) {
      getSwapQuote();
    }
    Get.back();
  }

  void updateAmount2nd() {
    cryptoAmount2nd.value = usdAmount2nd.value / secondToken.value.priceInUsd;
  }

  // Calculate percentage of balance
  void calculatePercentage(double percentage) {
    // Calculate USD amount based on percentage of first token's balance in USD
    double maxUsdAmount = firstToken.value.balanceInUsd;
    double calculatedUsdAmount = (maxUsdAmount * percentage) / 100;
    
    // Update the balance controller with the calculated amount
    balanceController.text = calculatedUsdAmount.toStringAsFixed(2);
    
    // Update amounts using existing method
    updateAmount(calculatedUsdAmount.toString(), firstToken.value.priceInUsd);
  }
}

