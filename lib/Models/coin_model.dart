class Coin {
  final int id;
  final String name;
  final String symbol;
  final double price;
  final String logoUrl;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.price,
    this.logoUrl = '',
  });

  // Factory method to create a copy with updated fields
  Coin copyWith({String? logoUrl}) {
    return Coin(
      id: id,
      name: name,
      symbol: symbol,
      price: price,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'], // Fetching symbol
      price: json['quote']['USD']['price'] ?? 0.0,
    );
  }
}
