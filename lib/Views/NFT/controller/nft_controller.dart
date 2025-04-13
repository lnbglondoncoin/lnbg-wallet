import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/nft_model.dart';
import 'package:http/http.dart' as http;

class NftController extends GetxController {
   var nftList = <NFTModel>[].obs;  // Observable list to store NFTs
var idController=TextEditingController();
var adressController=TextEditingController();
var isLoading = false.obs;
  var importedNFT = Rxn<NFTModel>();
  var errorMessage = ''.obs;
   var showImportednfts=false.obs;
 GlobalKey<FormState> importNftKey = GlobalKey();
  Future<void> importNFT({  

    required String walletAddress,
    required String nftAddress,
    required String collectibleId,
  }) async {
   
    isLoading.value = true;
   
    errorMessage.value = '';
    try {
      final response = await http.post(
        Uri.parse('http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/nfts/import'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'walletAddress': walletAddress,
          'nftAddress': nftAddress,
          'collectibleId': collectibleId,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        importedNFT.value = NFTModel.fromJson(data['nft']);
      await  fetchNFTs(walletAddress);
        Get.back();
      } else {
        errorMessage.value = data['message'] ?? 'Failed to import NFT';
      }
    } catch (e) {
        isLoading.value = false;
      errorMessage.value = 'Something went wrong: $e';
    } finally {
      isLoading.value = false;
    }
  }
Future<void> fetchNFTs(String walletAddress) async {
  final String apiUrl =
      'http://ec2-54-206-93-245.ap-southeast-2.compute.amazonaws.com:8000/api/nfts/$walletAddress';
print(apiUrl);
  try {
    isLoading(true);

    /// 🔥 Clear the list before loading new data
    nftList.clear();

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print("Response: ${data.toString()}");

      if (data['success'] == true && data['nfts'] != null) {
        List<dynamic> nfts = List<dynamic>.from(data['nfts']);
        print("NFTs: $nfts");

        nftList.value = nfts
            .map((nft) => NFTModel.fromJson(nft))
            .toList();

        print('NFTs fetched successfully!');
      } else {
        print('No NFTs found or failed to fetch!');
      }
    } else {
      print('Failed to load NFTs');
    }
  } catch (e) {
    isLoading(false);
    print('Error fetching NFTs: $e');
  } finally {
    isLoading(false);
  }
}

Future<String> getImageUrlFromIpfs(String ipfsMetadataUrl) async {
  final url = ipfsMetadataUrl.replaceFirst("ipfs://", "https://ipfs.io/ipfs/");
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final metadata = json.decode(response.body);
    final imageIpfs = metadata['image'];

    if (imageIpfs != null && imageIpfs.startsWith('ipfs://')) {
      return imageIpfs.replaceFirst("ipfs://", "https://ipfs.io/ipfs/");
    }
  }

  throw Exception('Failed to load NFT image from metadata');
}
}






