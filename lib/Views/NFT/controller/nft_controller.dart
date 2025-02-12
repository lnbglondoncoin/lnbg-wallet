import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/nft_model.dart';

class NftController extends GetxController {
  var nftList = <NftModel>[
    NftModel(imageUrl: 'assets/images/nft1.png', name: 'Nekochimin', id: 33),
    NftModel(imageUrl: 'assets/images/nft2.png', name: 'Nekochimin', id: 309),
    NftModel(imageUrl: 'assets/images/nft3.png', name: 'Nekochimin', id: 359),
    NftModel(imageUrl: 'assets/images/nft4.png', name: 'Nekochimin', id: 385),
  ].obs;
}
