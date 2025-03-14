// class CoinBalanceModel {
//   final double usdBalance;
//   final double balance;

//   CoinBalanceModel({
//     required this.balance,
//     required this.usdBalance,
//   });

//   // Convert a CoinBalanceModel instance to a JSON object
//   Map<String, dynamic> toJson() {
//     return {
//       'balance': balance,
//       'balanceInUsd': usdBalance,
//     };
//   }

//  factory CoinBalanceModel.fromJson(String key, Map<String, dynamic> json) {
//   return CoinBalanceModel(
//     balance: (json['balance'] as num).toDouble(),
//     usdBalance: (json['balanceInUsd'] as num).toDouble(),
//   );
// }

// }
