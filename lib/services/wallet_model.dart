class WalletBalanceResponse {
  final bool success;
  final Result result;

  WalletBalanceResponse({required this.success, required this.result});

  factory WalletBalanceResponse.fromJson(Map<String, dynamic> json) {
    return WalletBalanceResponse(
      success: json['success'],
      result: Result.fromJson(json['result']),
    );
  }
}

class Result {
  final bool available;
  final String secretType;
  final int balance;
  final double gasBalance;
  final String symbol;
  final String gasSymbol;
  final String rawBalance;
  final String rawGasBalance;
  final int decimals;

  Result({
    required this.available,
    required this.secretType,
    required this.balance,
    required this.gasBalance,
    required this.symbol,
    required this.gasSymbol,
    required this.rawBalance,
    required this.rawGasBalance,
    required this.decimals,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      available: json['available'],
      secretType: json['secretType'],
      balance: json['balance'],
      gasBalance: json['gasBalance'].toDouble(),
      symbol: json['symbol'],
      gasSymbol: json['gasSymbol'],
      rawBalance: json['rawBalance'],
      rawGasBalance: json['rawGasBalance'],
      decimals: json['decimals'],
    );
  }
}
