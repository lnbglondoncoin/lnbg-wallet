// class TokenModel {
//   final int id;
//   final String name;
//   final String symbol;
//   final double price;
//   final double marketCap;
//   final String logoUrl;

//   TokenModel({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.price,
//     required this.marketCap,
//     required this.logoUrl,
//   });

//   factory TokenModel.fromJson(Map<String, dynamic> json) {
//     return TokenModel(
//       id: json['id'],
//       name: json['name'],
//       symbol: json['symbol'],
//       price: json['price'].toDouble(),
//       marketCap: json['market_cap'].toDouble(),
//       logoUrl: json['logo_url'],
//     );
//   }
// }
