class TransactionModel {
  final String hash;
  final String method;
  final String time;
  final String from;
  final String to;
  final double amount;
  final double fee;
  final String token;
  final String fromToken;
  final String toToken;
  final String tokenSent;

  TransactionModel({
    required this.hash,
    required this.method,
    required this.time,
    required this.from,
    required this.to,
    required this.amount,
    required this.fee,
    required this.token,
    required this.fromToken,
    required this.toToken,
    required this.tokenSent,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      hash: json['hash'] ?? '',
      method: json['method'] ?? '',
      time: json['time'] ?? '',
      from: json['from'] ?? '',
      to: json['to'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      fee: (json['fee'] ?? 0).toDouble(),
      token: json['token'] ?? '',
      fromToken: json['fromToken'] ?? '',
      toToken: json['toToken'] ?? '',
      tokenSent: json['details']?['tokenSent'] ?? '',
    );
  }
}
