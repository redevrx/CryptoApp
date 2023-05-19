import 'package:crypto_search/model/crypto/bpi.dart';
import 'package:crypto_search/model/crypto/time.dart';

class CryptoData {
  Time time;
  String disclaimer;
  String chartName;
  Bpi bpi;

  CryptoData({
    required this.time,
    required this.disclaimer,
    required this.chartName,
    required this.bpi,
  });

  factory CryptoData.fromJson(Map<String, dynamic> json) => CryptoData(
    time: Time.fromJson(json["time"]),
    disclaimer: json["disclaimer"],
    chartName: json["chartName"],
    bpi: Bpi.fromJson(json["bpi"]),
  );

  Map<String, dynamic> toJson() => {
    "time": time.toJson(),
    "disclaimer": disclaimer,
    "chartName": chartName,
    "bpi": bpi.toJson(),
  };
}


