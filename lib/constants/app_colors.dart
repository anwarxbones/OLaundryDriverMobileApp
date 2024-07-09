import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color gold = Color(0xFF01b894);
  static const Color black = Color(0xFF001733);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFFF4141);
  static const Color gray = Color(0xFFC1C1C1);
  static const Color grayBG = Color(0xFFF7F7F7);
  static const Color goldenButton = Color(0xFF01b894);
  static const Color navyButton = Color(0xFF294366);
  static const Color navyText = Color(0xFF788493);

  //Card Colors
  static const Color cardGreen = Color(0xFFB0DF12);
  static const Color cardDeepGreen = Color(0xFF01b894);

  static MaterialColor themeColor = const MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );
}
