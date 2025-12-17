import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff188E69),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.grey[100],
    cardColor: Colors.white,
    shadowColor: Colors.black12,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff188E69),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff22B586),
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xff121212),
    cardColor: const Color(0xff1E1E1E),
    shadowColor: Colors.black54,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
