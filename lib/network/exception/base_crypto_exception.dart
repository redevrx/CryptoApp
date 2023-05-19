abstract class BaseCryptoException implements Exception {
  final String message;
  BaseCryptoException({required this.message});

  @override
  String toString() => message;
}