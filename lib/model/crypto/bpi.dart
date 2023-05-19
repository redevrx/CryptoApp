import 'package:crypto_search/model/crypto/eur.dart';

class Bpi {
  Eur usd;
  Eur gbp;
  Eur eur;

  Bpi({
    required this.usd,
    required this.gbp,
    required this.eur,
  });

  factory Bpi.fromJson(Map<String, dynamic> json) => Bpi(
    usd: Eur.fromJson(json["USD"]),
    gbp: Eur.fromJson(json["GBP"]),
    eur: Eur.fromJson(json["EUR"]),
  );

  Map<String, dynamic> toJson() => {
    "USD": usd.toJson(),
    "GBP": gbp.toJson(),
    "EUR": eur.toJson(),
  };
}