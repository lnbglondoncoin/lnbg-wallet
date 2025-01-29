import 'dart:math';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:hex/hex.dart';

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicKey(String privateKey);
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

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
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
}
