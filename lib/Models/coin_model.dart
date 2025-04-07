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
      logoUrl: json["logo_url"] ?? "",
      name: name,
      balance: json["balance"]?.toDouble() ?? 0.0,
      balanceInUsd: json["balanceInUsd"]?.toDouble() ?? 0.0,
      priceInUsd: json["priceInUsd"]?.toDouble() ?? 0.0,
      trend: json["trend"] ?? "",
      trendPercentage: json["trendPercentage"]?.toDouble() ?? 0.0,
    );
  }
}
