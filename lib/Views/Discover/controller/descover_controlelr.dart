import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/crypto_model.dart';


class DiscoverController extends GetxController {
 

var skatingCryptoList= <CryptoModel>[
    CryptoModel(name: "Solana", symbol: "SOL", imageUrl: "assets/icons/solana.png", price: 42.00, category: "Staking", percentage: "+7.12"),
    CryptoModel(name: "Status", symbol: "SNT", imageUrl: "assets/icons/status.png", price: 0.25, category: "Staking", percentage:"+0.13"),
    CryptoModel(name: "Polkadot New", symbol: "DOT", imageUrl: "assets/icons/polkadot.png", price: 6.75, category: "Staking", percentage: "-5.39"),

].obs;


var lendingBorrowing= <CryptoModel>[
  CryptoModel(name: "The Graph", symbol: "GRT", imageUrl: "assets/icons/graph.png", price: 8.76, category: "Lending / Borrowing",percentage: "+4.43"),
    CryptoModel(name: "Starg", symbol: "STARG", imageUrl: "assets/icons/starg.png", price: 15.53, category: "Lending / Borrowing",percentage: "+8.12"),
    CryptoModel(name: "Neo", symbol: "NEO", imageUrl: "assets/icons/neo.png", price: 6.51, category: "Lending / Borrowing",percentage: "+2.99"),

].obs;
var deFiTokens= <CryptoModel>[
  // DeFi Tokens
    CryptoModel(name: "Theta Fuel", symbol: "TFUEL", imageUrl: "assets/icons/theta.png", price: 7.50, category: "DeFi Tokens",percentage: "+12.56"),
    CryptoModel(name: "Orion", symbol: "ORN", imageUrl: "assets/icons/orion.png", price: 9.28, category: "DeFi Tokens",percentage:"+2.04"),
    CryptoModel(name: "AMP", symbol: "AMP", imageUrl: "assets/icons/amp.png", price: 3.29, category: "DeFi Tokens",percentage: "+9.12"),

].obs;
var smartChainBSC= <CryptoModel>[
 CryptoModel(name: "Shiba Inu", symbol: "SHIB", imageUrl: "assets/icons/shiba.png", price: 1.16, category: "Smart Chain / BSC",percentage: "+7.26"),
    CryptoModel(name: "Axie Infinity", symbol: "AXS", imageUrl: "assets/icons/axie.png", price: 13.23, category: "Smart Chain / BSC",percentage: "+0.44"),
    CryptoModel(name: "Symbol", symbol: "XYM", imageUrl: "assets/icons/symbol.png", price: 17.50, category: "Smart Chain / BSC",percentage: "+1.65"),

].obs;
var draft= <CryptoModel>[
    // Draft
    CryptoModel(name: "Decentraland", symbol: "MANA", imageUrl: "assets/icons/mana.png", price: 4.20, category: "Draft",percentage:" 0.0"),
    CryptoModel(name: "Syntix", symbol: "SYN", imageUrl: "assets/icons/syntix.png", price: 5.75, category: "Draft",percentage: "0.0"),
    CryptoModel(name: "Monero", symbol: "XMR", imageUrl: "assets/icons/monero.png", price: 6.81, category: "Draft",percentage:"0.0"),
].obs;

var categories=[
  "Staking",
  "Lending / Borrowing",
  "DeFi Tokens",
  "Smart Chain / BSC",
   "Draft"
].obs;
}


