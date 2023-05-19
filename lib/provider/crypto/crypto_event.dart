sealed class CryptoEvent {}

class InitDatabase extends CryptoEvent {}

class FetchCrypto extends CryptoEvent {}

class FetchHistoryCrypto extends CryptoEvent {}

class ConvertToBTC extends CryptoEvent {
  final double rate;

  ConvertToBTC({required this.rate});
}

class PriceInputChange extends CryptoEvent {
  final String price;

  PriceInputChange({required this.price});
}

class ClearPrice extends CryptoEvent {}