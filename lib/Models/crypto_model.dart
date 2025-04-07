class CryptoModel {
  final String name;
  final String symbol;
  final String imageUrl;
  final double price;
  final String category;
  final String percentage;

  CryptoModel({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.percentage,
  });

  // Factory method to parse JSON correctly
  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      name: json['name'] ?? "",
      symbol: json['symbol'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      price: json['price']?.toDouble() ?? 0.0,
      category: json['category'] ?? "",
      percentage:
          json['category'] ?? "", // ✅ Stores correctly as positive or negative
    );
  }
}
