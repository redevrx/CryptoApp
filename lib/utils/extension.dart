import 'package:flutter/cupertino.dart';

extension SizeBoxExtension on double {
  SizedBox toHeight({double height = 1.0}) {
    return SizedBox(height: this * height);
  }
}

extension StringToDouble on String {
  double toDouble() {
    return this == "" ? 0.0 : double.parse(replaceAll(RegExp(r'[^0-9.]'), ''));
  }
}
