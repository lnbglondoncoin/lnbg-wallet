import 'dart:convert';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Constants/app_constants.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_blnc_model.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/BottomNavigationBar/view/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;
abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicKey(String privateKey);
   loadWaletData();
}

class WalletCreatingController extends GetxController
    implements WalletAddressService {
  var mnemonic = ''.obs;
  var mnemonicWords = [].obs;
  var firstHalfOfMnemonic = [].obs;
  var secondHalfofMnemonic = [].obs;

  @override
  void onInit() {
    super.onInit();

    mnemonic.value = generateMnemonic();
    mnemonicWords.value = mnemonic.split(' ');
    firstHalfOfMnemonic.value = mnemonicWords.sublist(0, 6);
    secondHalfofMnemonic.value = mnemonicWords.sublist(6, 12);
    loadWaletData();
     fetchCoinData();
  }

  //variablr for private key
  String? privateKey;
  Future<void> loadPrivateKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    privateKey = prefs.getString('privateKey');
  }

  Future<void> setPrivateKey(String privateKey) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKey', privateKey);
    //reove both
    update();
    refresh();
  }

   Future<void> savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
    getPassword();
    //reove both
    update();
    refresh();
  }
String? password;
  Future<void> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    password = prefs.getString('password');
    print(seedPhrase);
  }
 

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    await setPrivateKey(privateKey);
 // Get.log("privetekey is:$privateKey");
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.address;
    return address;
  }

  var shuffledList = [].obs;
  var shuffleFirstPart = [].obs;
  void shuffleList(List inputList) {
    final random = Random();
    List tempList = List.from(inputList);
    tempList.shuffle(random);
    shuffledList.assignAll(tempList);
  }

  void shuffleFirstList(List inputList) {
    final random = Random();
    List tempList = List.from(inputList);
    tempList.shuffle(random);
    shuffleFirstPart.assignAll(tempList);
  }

  var orderList = [].obs;
  addInOrderList(String phrase) {
    if (orderList.contains(phrase)) {
      orderList.remove(phrase);
    } else {
      orderList.add(phrase);
    }
  }

  var indexes = [].obs;
  addIndexesToList(index) {
    if (indexes.contains(index)) {
      indexes.remove(index);
    } else {
      indexes.add(index);
    }
  }

  var isTrue = true.obs;
  changeisTrue(value) {
    isTrue.value = value;
  }



  var wallwtAddress=''.obs;
var balance=''.obs;
var pvKey=''.obs;
@override //remove override if problem coes in persistent login
Future<void> loadWaletData() async {
 
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? privateKey = prefs.getString('privateKey');
 // print("Private Key Loaded: $privateKey");

  if (privateKey != null) {
    await loadPrivateKey();
    EthereumAddress address = await getPublicKey(privateKey);
    wallwtAddress.value = address.hex;
    pvKey.value = privateKey;
  } else {
    print("No private key found in SharedPreferences");
  }
}





   Future<void> savePhraseToPrefs(String seedPhrase) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('seedPhrase', seedPhrase);
    //reove both
    update();
    refresh();

 final privateKey = await getPrivateKey(seedPhrase);
 setPrivateKey(privateKey);
    getSeedPhrase();
  }

    //variablr for private key
  String? seedPhrase;
  Future<void> getSeedPhrase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seedPhrase = prefs.getString('seedPhrase');
    print(seedPhrase);
  }


     String get cmcApiKey => dotenv.env['CMC_API_KEY'] ?? '';
  
  // final RxList<Coin> coins = <Coin>[].obs;
  var slugs = <String>[].obs;
var isLoading=false.obs;


//Function without bitcoin...
Future<void> fetchCoinData() async {
  const String baseUrl =
      "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=5";

  try {
    isLoading(true);
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {"X-CMC_PRO_API_KEY": cmcApiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      print(json.decode(response.body)['data']);

      // Filter out objects where name == "Bitcoin"
      final filteredData = data.where((coin) => coin['name'] != "Bitcoin").toList();

      // Extract slugs and store them in the observable list
      slugs.assignAll(filteredData.map((coin) => coin['slug'].toString()).toList());
await fetchWalletData(wallwtAddress.value);
     
    }
  } catch (e) {
    print("Error fetching coin data: $e");
    Get.snackbar("Error", e.toString());
  } finally {
    isLoading(false);
  }
}



var tBlnc=''.obs;
 Future<double> getNativeBalance(String walletAddress) async { 
  Get.log("private key is $privateKey comes hereeee");

  final Web3Client client = Web3Client("https://mainnet.infura.io/v3/${dotenv.env['INFURA_API_KEY']}", http.Client());
   EthereumAddress address = EthereumAddress.fromHex(walletAddress); 
   EtherAmount balance = await client.getBalance(address); 
   double ethBalance = balance.getValueInUnit(EtherUnit.ether);
   tBlnc.value=ethBalance.toString();
   Get.offAll(() => const BottomNavBar());
    return ethBalance;
    
     }




 var tokenData = <TokenData>[].obs;


  Future<void> fetchWalletData(String walletAddress) async {
    isLoading(true);
     String url =
        "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/wallet/$walletAddress/token-balances";

    final Map<String, dynamic> requestBody = {
      "tokens": slugs
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        List<TokenData> tokens = [];

        data.forEach((key, value) {
          tokens.add(TokenData.fromJson(key, value));
        });

        tokenData.assignAll(tokens);
        getNativeBalance(walletAddress);
      } else {
        Get.snackbar("Error", "Failed to load data");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading(false);
    }
  }
    }

  //function with bitcoin
// Future<void> fetchCoinData() async {
  
//   const String baseUrl =
//       "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=5";

//   try {
//     isLoading(true);
//     final response = await http.get(
//       Uri.parse(baseUrl),
//       headers: {"X-CMC_PRO_API_KEY": apiKey},
//     );

//     if (response.statusCode == 200) {
      
//       final data = json.decode(response.body)['data'] as List;
//       print(json.decode(response.body)['data']);
//         // Extract slugs and store them in the observable list
//       slugs.assignAll(data.map((coin) => coin['slug'].toString()).toList());

//       List<Coin> coinList = data.map((coin) => Coin.fromJson(coin)).toList();
      
//       // Fetch additional token data (logos)
//       final String detailsUrl =
//           "https://pro-api.coinmarketcap.com/v1/cryptocurrency/info";
//       final ids = coinList.map((coin) => coin.id).join(",");

//       final detailResponse = await http.get(
//         Uri.parse("$detailsUrl?id=$ids"),
//         headers: {"X-CMC_PRO_API_KEY": apiKey},
//       );

//       if (detailResponse.statusCode == 200) {
        
//         final detailedData =
//             json.decode(detailResponse.body)['data'] as Map<String, dynamic>;

//         // Create a new list with updated logo URLs
//         List<Coin> updatedCoins = coinList.map((coin) {
//           return coin.copyWith(
//               logoUrl: detailedData[coin.id.toString()]['logo'] ?? "");
//         }).toList();

//         coins.assignAll(updatedCoins);
//      // fetchBalances();
//    print("slugs are:$slugs");
  
//   await fetchCoinBalance(wallwtAddress.value);
       
//       }
//     }
//   } catch (e) {
//     print("Error fetching coin data: $e");
//     Get.snackbar("Error", e.toString());
//   } finally {
//     isLoading(false);
//   }
// }



// List<Coin> coinList = filteredData.map((coin) => Coin.fromJson(coin)).toList();

      // Fetch additional token data (logos)
      // final String detailsUrl =
      //     "https://pro-api.coinmarketcap.com/v1/cryptocurrency/info";
    //  final ids = coinList.map((coin) => coin.id).join(",");

      // final detailResponse = await http.get(
      //   Uri.parse("$detailsUrl?id=$ids"),
      //   headers: {"X-CMC_PRO_API_KEY": apiKey},
      // );

      // if (detailResponse.statusCode == 200) {
      //   final detailedData =
      //       json.decode(detailResponse.body)['data'] as Map<String, dynamic>;

      //   // Create a new list with updated logo URLs
      //   List<Coin> updatedCoins = coinList.map((coin) {
      //     return coin.copyWith(
      //         logoUrl: detailedData[coin.id.toString()]['logo'] ?? "");
      //   }).toList();

      //   coins.assignAll(updatedCoins);
      //   print("Slugs are: $slugs");

      //   
      // }


      
//  final String infuraUrl = "https://mainnet.infura.io/v3/45bd97aab7504c318ccd3640b426d368"; // Replace with your Infura Project ID
//   late Web3Client web3;
  
 // RxDouble totalBalanceUSD = 0.0.obs;


// Future<double> getTokenBalance(String? contractAddress, String walletAddress, int decimals) async {
//   if (contractAddress == null || contractAddress.isEmpty) {
//     print("Contract address is null or empty. Returning 0.");
//     return 0.0;
//   }

//   try {
//     final contract = DeployedContract(
//       ContractAbi.fromJson(
//         '[{"constant":true,"inputs":[{"name":"_owner","type":"address"}],"name":"balanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"}]',
//         'ERC20',
//       ),
//       EthereumAddress.fromHex(contractAddress),
//     );

//     final balanceFunction = contract.function('balanceOf');
//     final balance = await web3.call(
//       contract: contract,
//       function: balanceFunction,
//       params: [EthereumAddress.fromHex(walletAddress)],
//     );

//     final BigInt rawBalance = balance.first as BigInt;
//     return rawBalance / BigInt.from(10).pow(decimals);
//   } catch (e) {
//     print("Error fetching token balance for $contractAddress: $e");
//     return 0.0;
//   }
// }

  // Future<void> fetchBalances() async {
  //   double totalBalance = 0.0;

  //   for (int i = 0; i < coins.length; i++) {
  //     double balance = await getTokenBalance(coins[i].contractAddress, wallwtAddress.value, coins[i].decimals);
  //     coins[i] = coins[i].copyWith(balance: balance);
  //     totalBalance += balance * coins[i].price; // Convert token balance to USD
  //   }

  //   totalBalanceUSD.value = totalBalance;

  //   update(); // Update UI
  //    Get.offAll(() => const BottomNavBar());
  // }


  
  // var coinBalances = <double>[].obs;
  // var coinBalaneInUsd=<double>[].obs;

  
//  var coinBalances = <CoinBalanceModel>[].obs;

//   Future<void> fetchCoinBalance(String walletAddress) async {
   
//     String url = "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/wallet/0x256822b9d3a2afd22b309745b7ddaeb9e99e88d9/token-balances";
    
//     print("Fetching balances for wallet: $walletAddress");

//     final Map<String, dynamic> requestBody = {
//       "tokens": slugs
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(requestBody),
//       );

//     if (response.statusCode == 200) {
//   final Map<String, dynamic> responseData = jsonDecode(response.body);
//   Get.log("API Response: $responseData");

//   List<CoinBalanceModel> balances = responseData.entries.map((entry) {
//     return CoinBalanceModel.fromJson(entry.key, entry.value as Map<String, dynamic>);
//   }).toList();

//   // Update the observable list
//   coinBalances.assignAll(balances);
//   Get.snackbar("response is", "$walletAddress");
//   getNativeBalance(walletAddress);
// } else {
//   Get.snackbar("Error: ${response.statusCode}", response.body);
// }
 
//     } catch (e) {
//      Get.snackbar("Error:" ,e.toString());
//     }
//   }

