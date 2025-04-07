import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:http/http.dart' as http;
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:web3dart/crypto.dart';
import 'dart:convert';
import 'dart:async';

import 'package:web3dart/web3dart.dart';

class SwapController extends GetxController {
  final walletCreatingCotroller = Get.find<WalletCreatingController>();
  var balanceController = TextEditingController();

  // Update constants for Sepolia testnet
  static const int chainIdd = 11155111; // Sepolia chain ID
  static const String rpcUrl = 'https://sepolia.infura.io/v3/';

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
      final swapFormKey = GlobalKey<FormState>();
  // Add a computed property to check if swap is possible
  bool get canSwap =>
      !isLoading.value && currentQuote.isNotEmpty && cryptoAmount.value > 0;

  // Add these new observable variables at the top of your controller
  RxString provider = "0x Protocol".obs;
  RxDouble maxSlippage = 0.0.obs;
  RxString networkFeeInEth = "0.000".obs;

  // Add getters for formatted display
  String get formattedProvider => provider.value;

  String get formattedSlippage {
    if (currentQuote.isEmpty) return "0.00%";
    try {
      double slippage =
          double.parse(currentQuote['slippagePercentage'] ?? '0.01') * 100;
      return "${slippage.toStringAsFixed(2)}%";
    } catch (e) {
      return "1.00%"; // Default fallback
    }
  }

  String get formattedNetworkFee {
    if (currentQuote.isEmpty) return "0.000 ETH";
    try {
      double estimatedGas = double.parse(currentQuote['estimatedGas']);
      double gasPrice = double.parse(currentQuote['gasPrice']);
      double fee = (estimatedGas * gasPrice) / 1e18;
      return "${fee.toStringAsFixed(5)} ETH";
    } catch (e) {
      return "0.000 ETH";
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (walletCreatingCotroller.tokenData.isNotEmpty) {
      firstToken.value = walletCreatingCotroller.tokenData[0];
      secondToken.value = walletCreatingCotroller.tokenData[1];
      oneFirstCoinEquelsSecondCoins.value=firstToken.value.priceInUsd / secondToken.value.priceInUsd;
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
        getSwapQuote();
      }
    } catch (e) {
      //  print('Error in updateAmount: $e');
    }
  }

  // Get real-time quote from 1inch
  Future<void> getSwapQuote() async {
    if (cryptoAmount.value <= 0) return;

    try {
      isLoading(true);

      String amount = (cryptoAmount.value * 1e18).toStringAsFixed(0);

      // Use Sepolia API endpoint
      final url = Uri.parse('https://sepolia.api.0x.org/swap/v1/quote?'
          'sellToken=ETH'
          '&buyToken=0x68194a729C2450ad26072b3D33ADaCbcef39D574' // Sepolia DAI address
          '&sellAmount=$amount'
          '&chainId=$chainIdd');

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          '0x-api-key': '9a827917-91ba-4739-87f9-23451d511ea6',
        },
      );

      if (response.statusCode == 200) {
        final quote = json.decode(response.body);
        currentQuote.value = quote;

        // Update slippage from quote
        maxSlippage.value =
            double.parse(quote['slippagePercentage'] ?? '0.01') * 100;

        // Calculate network fee
        networkFee.value = double.parse(quote['estimatedGas']) *
            double.parse(quote['gasPrice']) /
            1e18;

        // Calculate the exchange rate
        double fromAmount =
            double.parse(quote['sellAmount']) / 1e18; // ETH decimals
        double toAmount =
            double.parse(quote['buyAmount']) / 1e6; // USDT decimals

        swapRate.value = toAmount / fromAmount;

        // Update second token amounts
        cryptoAmount2nd.value = toAmount;
        usdAmount2nd.value = toAmount * secondToken.value.priceInUsd;

        updateAmount2nd();
      } else {
        throw Exception('API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get quote. Please try again.',
        duration: const Duration(seconds: 3),
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
  // Add validation methods
  String? validateBLance(String? value) {
    if (value == null || value.isEmpty) {
      return 'Balance is required';
    }
 else if (value == "0") {
       return "Balance cannot be zero";
      }
    // Add additional address validation if needed
    return null;
  }
   bool validateForm() {
    return swapFormKey.currentState?.validate() ?? false;
  }
  // Execute swap
  Future<void> executeSwap(BuildContext context) async {
    // debugPrintSwapDetails();
    try {
      isLoading(true);

      if (currentQuote.isEmpty) {
        throw Exception('No valid quote found');
      }

      String amount = (cryptoAmount.value * 1e18).toStringAsFixed(0);

      final url = Uri.parse('https://api.0x.org/swap/v1/quote?'
          'sellToken=ETH'
          '&buyToken=USDT'
          '&sellAmount=$amount'
          '&slippagePercentage=0.01');

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          '0x-api-key': '9a827917-91ba-4739-87f9-23451d511ea6',
        },
      );

      if (response.statusCode == 200) {
        final swapQuote = json.decode(response.body);

        if (!swapQuote.containsKey('to') || !swapQuote.containsKey('data')) {
          throw Exception('Invalid quote format received');
        }

        await submitTransaction(swapQuote, context);

        resetSwap();
        balanceController.clear();

        Get.snackbar(
          'Success',
          'Swap order created successfully',
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        throw Exception('Failed to get swap quote: ${response.body}');
      }
    } catch (e) {
       isLoading(false);
     // print('Full error details in executeSwap: $e');
      // Get.snackbar(
      //   'Error',
      //   'Swap failed: ${e.toString()}',
      //   duration: const Duration(seconds: 3),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      
_showFailPopup(context,e.toString().contains("INSUFFICIENT_ASSET_LIQUIDITY")?"INSUFFICIENT_ASSET_LIQUIDITY,  TRY SMALL AMMOUNT":e.toString());
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
            updateAmount2nd();  
      getSwapQuote();
    }
    //   updateAmount("1", firstToken.value.priceInUsd);
      updateAmount2nd();
    Get.back();
  }

  void updateSecondToken(TokenData token) {
    secondToken.value = token;
    if (usdAmount.value > 0) {
   updateAmount2nd();
      getSwapQuote();
    }
   
     // updateAmount("1", secondToken.value.priceInUsd);
      updateAmount2nd();
    Get.back();
  }

  var oneFirstCoinEquelsSecondCoins = 0.0.obs;
  void updateAmount2nd() {
    cryptoAmount2nd.value = usdAmount2nd.value / secondToken.value.priceInUsd;
    oneFirstCoinEquelsSecondCoins.value =
        firstToken.value.priceInUsd / secondToken.value.priceInUsd;
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

  Future<void> submitTransaction(
      Map<String, dynamic> swapQuote, BuildContext context) async {
    try {
      // Use Sepolia testnet URL
      final client = Web3Client(
        "$rpcUrl${dotenv.get('INFURA_API_KEY')}",
        http.Client(),
      );

      try {
        final credentials =
            EthPrivateKey.fromHex(walletCreatingCotroller.privateKey!);

        // Check balance first
        final address = credentials.address;
        final balance = await client.getBalance(address);

        final gasPrice = await client.getGasPrice();
        final estimatedGas =
            BigInt.from(int.parse(swapQuote['gas'] ?? '150000'));
        final value = BigInt.parse(swapQuote['value'] ?? '0');

        // Calculate total cost (value + gas)
        final gasCost = gasPrice.getInWei * estimatedGas;
        final totalCost = value + gasCost;

        // Check if user has enough balance
        if (balance.getInWei < totalCost) {
          throw Exception('''
Insufficient balance!
Required: ${EtherAmount.fromBigInt(EtherUnit.wei, totalCost).getValueInUnit(EtherUnit.ether)} ETH
Available: ${balance.getValueInUnit(EtherUnit.ether)} ETH
          ''');
        }

        final transaction = Transaction(
          to: EthereumAddress.fromHex(swapQuote['to']),
          value: EtherAmount.inWei(value),
          data: hexToBytes(swapQuote['data']),
          maxGas: int.parse(swapQuote['gas'] ?? '150000'),
          gasPrice: gasPrice,
          nonce: await client.getTransactionCount(address),
        );

        // Send transaction with Sepolia chain ID
        final txHash = await client.sendTransaction(
          credentials,
          transaction,
          chainId: chainIdd, // Sepolia chain ID
        );

        // Monitor transaction
        bool confirmed = false;
        int attempts = 0;

        while (!confirmed && attempts < 30) {
          try {
            final receipt = await client.getTransactionReceipt(txHash);
            if (receipt != null) {
              confirmed = true;
              Get.snackbar(
                'Success',
                'Transaction confirmed! Hash: ${txHash.substring(0, 10)}...',
                duration: const Duration(seconds: 3),
                snackPosition: SnackPosition.BOTTOM,
              );
              _showSuccesPopup(context);
              break;
            }
          } catch (e) {
            // print('Waiting for confirmation... Attempt ${attempts + 1}');
          }
          await Future.delayed(const Duration(seconds: 2));
          attempts++;
        }
      } finally {
        client.dispose();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
      );
      throw Exception('Transaction submission failed: $e');
    }
  }

  // Add method to update slippage
  void updateSlippage(double newSlippage) {
    maxSlippage.value = newSlippage;
    // Refresh quote with new slippage
    if (cryptoAmount.value > 0) {
      getSwapQuote();
    }
  }

  // // Add this method to help debug
  // void debugPrintSwapDetails() {
  //   print('Debug Swap Details:');
  //   print('Crypto Amount: ${cryptoAmount.value}');
  //   print('USD Amount: ${usdAmount.value}');
  //   print('First Token: ${firstToken.value.symbol}');
  //   print('Second Token: ${secondToken.value.symbol}');
  //   print('Current Quote: ${currentQuote}');
  // }
 void _showFailPopup(BuildContext context, String message) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
          backgroundColor: isDarkMode ? lightBlackColor2 : whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon: Image.asset(
            isDarkMode ? "assets/images/fail2.png" : "assets/images/fail.png",
            height: 180.h,
            width: 186.w,
          ),
          title: Text(
            "Oops.. .Failed!",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp, fontWeight: FontWeight.w700, color: pinkColor),
          ),
          content: Text(
              textAlign: TextAlign.center,
              message,
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? whiteColor : blackColor2)),
          actions: [
            isDarkMode
                ? CustomGreenButton(
                    buttonText: "Try Again",
                    onPressed: () {
                      Navigator.pop(context);
                    })
                : GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 58.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          gradient:
                              const LinearGradient(colors: [orange2, orange1])),
                      child: Center(
                        child: Text(
                          "Try Again",
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                              color: whiteColor),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 15.h,
            ),
            CustomLightGreenButton(
                buttonText: "Cancel",
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }


  void _showSuccesPopup(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          actionsPadding:
              EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w, top: 10.h),
          backgroundColor: isDarkMode ? lightBlackColor2 : whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          icon: Image.asset(
            isDarkMode
                ? "assets/images/swap_success2.png"
                : "assets/images/swap_success.png",
            height: 180.h,
            width: 186.w,
          ),
          title: Text(
            "Successful Swap!",
            style: GoogleFonts.urbanist(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? lightGreenColor : orange3),
          ),
          content: Text(
              textAlign: TextAlign.center,
              "Your crypto was swap successfully. You can view more details below.",
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? whiteColor : blackColor2)),
          actions: [
            isDarkMode
                ? CustomGreenButton(
                    buttonText: "View Details",
                    onPressed: () {
                      Navigator.pop(context);
                    })
                : GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 58.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          gradient:
                              const LinearGradient(colors: [orange2, orange1])),
                      child: Center(
                        child: Text(
                          "View Details",
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                              color: whiteColor),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 15.h,
            ),
            CustomLightGreenButton(
                buttonText: "Cancel",
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }
}
