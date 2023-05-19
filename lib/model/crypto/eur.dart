class Eur {
  String code;
  String symbol;
  String rate;
  String description;
  double rateFloat;

  Eur({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });

  factory Eur.fromJson(Map<String, dynamic> json) => Eur(
    code: json["code"],
    symbol: json["symbol"],
    rate: json["rate"],
    description: json["description"],
    rateFloat: json["rate_float"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "symbol": symbol,
    "rate": rate,
    "description": description,
    "rate_float": rateFloat,
  };
}
