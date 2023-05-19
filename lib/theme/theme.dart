import 'package:crypto_search/theme/app_colors.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: kDarkBgColor,
  primaryColor: kDarkItem,
  textTheme: const TextTheme(
    displayMedium: TextStyle(fontSize: 32.0,color: Colors.white,fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 22.0,color: Colors.white,fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 11.0,color: Colors.white,fontWeight: FontWeight.w500)
  )
);