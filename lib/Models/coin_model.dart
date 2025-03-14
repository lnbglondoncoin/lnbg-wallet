// class Coin {
//   final int id;
//   final String name;
//   final String symbol;
//   final String contractAddress; // Smart contract address of the token
//   final int decimals; // Number of decimal places for the token
//   final double price;
//   final String logoUrl;
//   final double percentage;
//   double balance; // User's balance for this token

//   Coin({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.contractAddress,
//     required this.decimals,
//     required this.price,
//     this.logoUrl = '',
//     required this.percentage,
//     this.balance = 0.0, // Default balance is 0
//   });

//   // Factory method to create a copy with updated fields
//   Coin copyWith({String? logoUrl, double? balance}) {
//     return Coin(
//       id: id,
//       name: name,
//       symbol: symbol,
//       contractAddress: contractAddress,
//       decimals: decimals,
//       price: price,
//       logoUrl: logoUrl ?? this.logoUrl,
//       percentage: percentage,
//       balance: balance ?? this.balance,
//     );
//   }

// factory Coin.fromJson(Map<String, dynamic> json) {
//   print("Coin JSON: $json");

//   return Coin(
//     id: json['id'],
//     name: json['name'],
//     symbol: json['symbol'], 
//        contractAddress: json['platform'] != null ? json['platform']['contract_address'] ?? 'N/A' : 'N/A', // Fix here
//     decimals: json['decimals'] ?? 18, 
//     price: json['quote']?['USD']?['price'] ?? 0.0,
//     percentage: json['quote']?['USD']?['percent_change_24h'] ?? 0.0,
//   );
// }

// }



class TokenData {
  final String symbol;
  final String logoUrl;
  final String contractAddress;
  final String name;
  final double balance;
  final double balanceInUsd;
  final double priceInUsd;
  final String trend;
  final double trendPercentage;

  TokenData({
    required this.symbol,
    required this.logoUrl,
    required this.contractAddress,
    required this.name,
    required this.balance,
    required this.balanceInUsd,
    required this.priceInUsd,
    required this.trend,
    required this.trendPercentage,
  });

  factory TokenData.fromJson(String name, Map<String, dynamic> json) {
    return TokenData(
      symbol: json["symbol"] ?? "",
      contractAddress: json["contract_address"] ?? "",
      logoUrl:json["logo_url"] ?? "" ,
      name: name,
      balance: json["balance"]?.toDouble() ?? 0.0,
      balanceInUsd: json["balanceInUsd"]?.toDouble() ?? 0.0,
      priceInUsd: json["priceInUsd"]?.toDouble() ?? 0.0,
      trend: json["trend"] ?? "",
      trendPercentage: json["trendPercentage"]?.toDouble() ?? 0.0,
    );
  }
}