import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
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
  String? privateKey=prefs.getString('privateKey');
  if(privateKey!=null){
  
     await loadPrivateKey();
     EthereumAddress address= await getPublicKey(privateKey);
     wallwtAddress.value=address.hex;
     pvKey.value=privateKey;
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


   final String apiKey = "8f1b91d4-485e-4a9e-8db2-92b8b3f6c94d";
  final RxList<Coin> coins = <Coin>[].obs;
var isLoading=false.obs;
Future<void> fetchCoinData() async {
  const String baseUrl =
      "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=5";

  try {
    isLoading(true);
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {"X-CMC_PRO_API_KEY": apiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      List<Coin> coinList = data.map((coin) => Coin.fromJson(coin)).toList();

      // Fetch additional token data (logos)
      final String detailsUrl =
          "https://pro-api.coinmarketcap.com/v1/cryptocurrency/info";
      final ids = coinList.map((coin) => coin.id).join(",");

      final detailResponse = await http.get(
        Uri.parse("$detailsUrl?id=$ids"),
        headers: {"X-CMC_PRO_API_KEY": apiKey},
      );

      if (detailResponse.statusCode == 200) {
        final detailedData =
            json.decode(detailResponse.body)['data'] as Map<String, dynamic>;

        // Create a new list with updated logo URLs
        List<Coin> updatedCoins = coinList.map((coin) {
          return coin.copyWith(
              logoUrl: detailedData[coin.id.toString()]['logo'] ?? "");
        }).toList();

        coins.assignAll(updatedCoins);
        Get.offAll(() => const BottomNavBar());
      }
    }
  } catch (e) {
    print("Error fetching coin data: $e");
    Get.snackbar("Error", e.toString());
  } finally {
    isLoading(false);
  }
}

}
