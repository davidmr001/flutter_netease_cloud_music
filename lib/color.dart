import 'package:flutter/material.dart';

class AppColors {
  static const int primaryValue = 0xFFe74939;
  static const Color primary = Color(primaryValue);

  static const int borderValue = 0xFFf4f4f4;
  static const Color border = Color(borderValue);


  static const int secondFontValue = 0xFF939393;
  static const Color secondFont = Color(secondFontValue);

  static const MaterialColor primaryMaterialColor = MaterialColor(
    primaryValue,
    <int, Color>{
      50: Color(0xFFf1b7b1),
      100: Color(0xFFf59f97),
      200: Color(0xFFf17b6f),
      300: Color(0xFFf16a5c),
      400: Color(0xFFec5c4d),
      500: Color(primaryValue),
      600: Color(0xFFe63321),
      700: Color(0xFFcc2312),
      800: Color(0xFFa01a0c),
      900: Color(0xFF7d1004),
    },
  );
}