import 'dart:convert';
import 'package:http/http.dart' as http;

class MoonPayService {
  // Replace with your MoonPay API key
  static const String apiKey = 'YOUR_MOONPAY_API_KEY';
  static const String baseUrl = 'https://api.moonpay.com/v3';

  // Get quote for swap
  Future<Map<String, dynamic>> getSwapQuote({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/quotes?apiKey=$apiKey'
          '&baseCurrencyCode=${fromCurrency.toLowerCase()}'
          '&quoteCurrencyCode=${toCurrency.toLowerCase()}'
          '&baseCurrencyAmount=$amount'
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get quote: ${response.body}');
      }
    } catch (e) {
      throw Exception('Quote error: $e');
    }
  }

  // Execute swap transaction
  Future<Map<String, dynamic>> executeSwap({
    required String quoteId,
    required String walletAddress,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/transactions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
         body: json.encode({
          'quoteId': quoteId,
          'walletAddress': walletAddress,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Swap failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Swap error: $e');
    }
  }
}