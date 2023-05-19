import 'package:flutter/cupertino.dart';

abstract class BaseCryptoProvider with ChangeNotifier {
  void onEvent<T>({required T event});
}