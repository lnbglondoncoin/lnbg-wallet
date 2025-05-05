import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
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
  loadWaletData(bool isAccountImported);
}

class WalletCreatingController extends GetxController
    implements WalletAddressService {
     // var isNewAccountCraeting=false.obs;
      var isAccountImporting=false.obs;
  var mnemonic = ''.obs;
  var mnemonicWords = [].obs;
  var firstHalfOfMnemonic = [].obs;
  var secondHalfofMnemonic = [].obs;
   var tokenData = <TokenData>[].obs;
  // var ethereumData = <TokenData>{}.obs;
  var nameController=TextEditingController();
   Rxn<TokenData> ethereumData = Rxn<TokenData>();
  String? seedPhrase;
  String get cmcApiKey => dotenv.env['CMC_API_KEY'] ?? '';
  var slugs = <String>[].obs;
  
  var isLoading = false.obs;
  var tBlnc = ''.obs;
  String? privateKey;
  String? password;
  var shuffledList = [].obs;
  var shuffleFirstPart = [].obs;
  var orderList = [].obs;
  var indexes = [].obs;
  var isTrue = true.obs;
  var wallwtAddress = ''.obs;
  var balance = ''.obs;
  var pvKey = ''.obs;
  @override
  void onInit() {
    super.onInit();
    mnemonic.value = generateMnemonic();
    mnemonicWords.value = mnemonic.split(' ');
    firstHalfOfMnemonic.value = mnemonicWords.sublist(0, 6);
    secondHalfofMnemonic.value = mnemonicWords.sublist(6, 12);
  fetchLNBGTokenData("LLC","LNBG London Coin");    
      fetchLNBGTokenData("ETH","Ethereum"); 
   
  }


 var hundredslugs = <String>[].obs;

  Future<void> fetchSlugs() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse("http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/wallet/top-100-token-slugs"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        hundredslugs.assignAll(List<String>.from(data['slugs']));
      await  fetchHundredTokens(wallwtAddress.value);
      } else {
        Get.snackbar('Error', 'Failed to fetch  100 Slugs');
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', e.toString());
    }
    finally{
      isLoading(false);
    }
  }
 var hundredTokenData = <TokenData>[].obs;
    Future<void> fetchHundredTokens(String walletAddress) async {
    String url =
        "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/wallet/$walletAddress/token-balances";


print("merge slugs are $hundredslugs");
    final Map<String, dynamic> requestBody = {"tokens": hundredslugs};

    try {
      isLoading.value = true; // Set loading to true at start

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        Get.log(response.body);
        List<TokenData> tokens = [];

        data.forEach((key, value) {
          tokens.add(TokenData.fromJson(key, value));
        });

      // ✅ Insert previously fetched tokenData at index 0 if available
      if (lnbgData.value != null) {
        tokens.insert(0, lnbgData.value!);
      }
      // Check for duplicate tokens and prioritize "lnbg-london-coin"
        tokens.removeWhere((token) =>
            token.name == "LNBG London Coin" &&
            tokens.any((t) => t.name == "lnbg-london-coin"));

        // Place "lnbg-london-coin" at index 0 if it exists
        final lnbgLondonCoinIndex = tokens.indexWhere((t) => t.name == "lnbg-london-coin");
        if (lnbgLondonCoinIndex != -1) {
          final lnbgLondonCoin = tokens.removeAt(lnbgLondonCoinIndex);
          tokens.insert(0, lnbgLondonCoin);}
          
     var mergedList = (tokens + tokenData).toSet().toList();
        hundredTokenData.assignAll(mergedList);

     
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "Failed to load 100 tokenData");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong with 1000 tokens");
    }
  }

  Future<void> loadPrivateKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    privateKey = prefs.getString('privateKey');
  }

  Future<void> setPrivateKey(String privateKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKey', privateKey);
    // update();
    // refresh();
  }

  Future<void> savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
    getPassword();
    // update();
    // refresh();
  }

  Future<void> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    password = prefs.getString('password');
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
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.address;
    return address;
  }

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

  addInOrderList(String phrase) {
    if (orderList.contains(phrase)) {
      orderList.remove(phrase);
    } else {
      orderList.add(phrase);
    }
  }

  addIndexesToList(index) {
    if (indexes.contains(index)) {
      indexes.remove(index);
    } else {
      indexes.add(index);
    }
  }

  changeisTrue(value) {
    isTrue.value = value;
  }

  @override //remove override if problem coes in persistent login
  Future<void> loadWaletData(bool isAccountImported) async {
    Get.log("Loading walletData");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? privateKey = prefs.getString('privateKey');

    if (privateKey != null) {
      await loadPrivateKey();
      EthereumAddress address = await getPublicKey(privateKey);
      await getSeedPhrase();
      wallwtAddress.value = address.hex;
      pvKey.value = privateKey;
      await fetchPreferences(wallwtAddress.value,false,isAccountImported);
    } else {}
  }

  Future<void> savePhraseToPrefs(String seedPhrase) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('seedPhrase', seedPhrase);
    update();
    refresh();

    final privateKey = await getPrivateKey(seedPhrase);
    setPrivateKey(privateKey);
    getSeedPhrase();
  }

  Future<void>  getSeedPhrase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seedPhrase = prefs.getString('seedPhrase');
  }

  Future<void> fetchPreferences(String walletAddress,bool isAppStarting,bool isAccountImported) async {
    
    final String url =
        "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/preferences/$walletAddress";
print(url);
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<String> tokens =
            List<String>.from(data["preferences"]["selectedTokens"]);
        slugs.assignAll(tokens);
       // print(slugs);
        if (slugs.isEmpty) {
          await fetchCoinData(isAppStarting,isAccountImported);
        } else {
          await fetchWalletData(wallwtAddress.value,isAppStarting,isAccountImported);
        }
      } else {
        Get.snackbar("Error", "Failed to fetch preferences: ${response.body}",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Errorrrr", "Something went wrong with peferences: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCoinData(bool isAppStarting,bool isAccountImported) async {
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

        // Filter out objects where name == "Bitcoin"
        final filteredData =
            data.where((coin) => coin['name'] != "Bitcoin").toList();

        // Extract slugs and store them in the observable list
        slugs.assignAll(
            filteredData.map((coin) => coin['slug'].toString()).toList());
        await fetchWalletData(wallwtAddress.value,isAppStarting,isAccountImported);
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar("Error with CMC slug loading", e.toString());
    } finally {
      isLoading(false);
    }
  }
var importngOrCreatingprocessCompletion=false.obs;
  Future<void> getBalanceInUSD(String walletAddress) async {
    try {
      print('come here');
       isLoading.value = true; // Set loading to false only at the very end
      // Don't set isLoading here since it's already true
      final response = await http.get(Uri.parse(
          "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/wallet/$walletAddress/balance-usd"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        tBlnc.value = data['balanceUsd'].toStringAsFixed(5);
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch balance: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
        tBlnc.value = '0';
      }
    } catch (e) {
       isLoading.value = false; // Set loading to false only at the very end
      Get.snackbar(
        'Error',
        'Failed to fetch balance',
        snackPosition: SnackPosition.BOTTOM,
      );
      tBlnc.value = '0';
    } finally {
      isLoading.value = false; // Set loading to false only at the very end
    }
  }



  Future<void> fetchWalletData(String walletAddress,bool isAppStarting,bool isAccountImported) async {
    print("slus are $slugs");
    // 🔁 Replace "Lnbg_London_Coin" with "lnbg-london-coin" in slugs list
  List<String> modifiedSlugs = slugs.map((slug) {
    return slug == "LNBG London Coin" ? "lnbg-london-coin" : slug;
  }).toList();

    String url =
        "http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/wallet/$walletAddress/token-balances";
print(url);
    final Map<String, dynamic> requestBody = {"tokens": modifiedSlugs};

    try {
      isLoading.value = true; // Set loading to true at start

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<TokenData> tokens = [];

        data.forEach((key, value) {
          tokens.add(TokenData.fromJson(key, value));
        });
       //  ✅ Insert previously fetched tokenData at index 0 if available
      if (lnbgData.value != null) {
        tokens.insert(0, lnbgData.value!);
      }
  // Check for duplicate tokens and prioritize "lnbg-london-coin"
        tokens.removeWhere((token) =>
            token.name == "LNBG London Coin" &&
            tokens.any((t) => t.name == "lnbg-london-coin"));

        // Place "lnbg-london-coin" at index 0 if it exists
        final lnbgLondonCoinIndex = tokens.indexWhere((t) => t.name == "lnbg-london-coin");
        if (lnbgLondonCoinIndex != -1) {
          final lnbgLondonCoin = tokens.removeAt(lnbgLondonCoinIndex);
          tokens.insert(0, lnbgLondonCoin);
        }
        tokenData.assignAll(tokens);
  
        await getBalanceInUSD(walletAddress);
        if(isAppStarting||isAccountImported){
        Get.log("comes here $isAppStarting");
        await  fetchSlugs();
        if(isAcccontCreated.value){
 await createUser(nameController.text, walletAddress);
}

  
        }
        await fetchUserData(walletAddress);
       Get.offAllNamed(AppRoutes.home);
      
      } else {
     //   isLoading.value = false;
        Get.snackbar("Errorrr", "Failed to load all slgs tokens");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong with all slugs tokens");
    }
    finally{
      isLoading(false);
    }
  }


var isAcccontCreated=false.obs;
   // Define a function to call the API
  Future<void> createUser(String name, String walletAddress) async {
    isLoading(true);  // Set loading to true

    try {
      // API URL
      final url = 'http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/users';

      // Prepare body
      final Map<String, String> body = {
        'name': name,
        'walletAddress': walletAddress,
      };

      // Send POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      // Check the response status code
      if (response.statusCode == 200) {
       // await fetchUserData(walletAddress);
         isAccountImporting.value=false;
      isAcccontCreated.value=false;
      importngOrCreatingprocessCompletion.value=true;
      } else {
       
      }
    } catch (e) {
      isLoading(false);  // Set loading to false after request is done
      Get.snackbar("Error ", "name not saved $e");
    
    } finally {
      isLoading(false);  // Set loading to false after request is done
    }
  }

 var userName = ''.obs;        // To store the returned string
 Future<void> fetchUserData(String walletAddress) async {
    isLoading(true);
    
    
    final url = 'http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/users/$walletAddress';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        userName.value = data['name'] ?? 'No name found';
          isAccountImporting.value=false;
      isAcccontCreated.value=false;
      importngOrCreatingprocessCompletion.value=true;
      } else {

      }
    } catch (e) {
       isLoading(false);
      Get.snackbar("Error", "Name not get $e");
    } finally {
      isLoading(false);
    }
  }


  var lnbgData = Rxn<TokenData>();


  Future<void> fetchLNBGTokenData(String symbol, String name) async {
    try {
      isLoading.value = true;
   

      final url = 'http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/wallet/$symbol/coin';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200||response.statusCode==204) {
        final data = json.decode(response.body);
        if(symbol=="LLC"){
 lnbgData.value = TokenData.fromJson(name, data);
        }
       
       else if(symbol=="ETH"){
        ethereumData.value =TokenData.fromJson(name, data);
       }
       else{

       }
      } else {
       // error.value = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Failed to get LNBG data:$e");
     // error.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
