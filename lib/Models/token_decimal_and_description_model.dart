class TokenDescriptionAndDecimalModel {
  final String description;
  final String decimals;
  final double circulatingSuply;
  final double voulme;
  final String website;

  TokenDescriptionAndDecimalModel({required this.description, required this.decimals,required this.circulatingSuply,required this.voulme,required this.website});

  factory TokenDescriptionAndDecimalModel.fromJson(Map<String, dynamic> json) {
    return TokenDescriptionAndDecimalModel(
      description: json['description'] ?? '',
      decimals: json['decimals'] ?? '',
       circulatingSuply: json['circulatingSupply'] ?? 0.0,
      voulme: json['volume24h'] ?? 0.0,
       website: json['website'] ?? '',
   
    );
  }
}