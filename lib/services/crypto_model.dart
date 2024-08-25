


class CryptoTracker {
  CryptoTracker({
    required this.id,
    required this.name,
    required this.symbol,
    required this.img,
    required this.currentPrice,
    required this.percentChange,
  });
  String id;
  String name;
  String symbol;
  String img;
  num currentPrice;
  double percentChange;

  factory CryptoTracker.fromJson(Map<String, dynamic> json) => CryptoTracker(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        img: json["image"],
        currentPrice: json["current_price"],
        percentChange: json['ath_change_percentage'],
      );
}

// class News{
//   News({

//   })
// }