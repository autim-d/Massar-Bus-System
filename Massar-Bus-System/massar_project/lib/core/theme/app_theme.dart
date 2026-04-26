import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF1570EF);
  static const Color backgroundLight = Color(0xFFFAFAFB);
  static const Color backgroundDark = Color(0xFF121212);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'ReadexPro',
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFF1D2939)),
      titleTextStyle: TextStyle(
        color: Color(0xFF1D2939),
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'ReadexPro',
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE4E7EC)),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1D2939)),
      bodyMedium: TextStyle(color: Color(0xFF667085)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'ReadexPro',
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1D2939),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'ReadexPro',
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1D2939),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Color(0xFF98A2B3)),
    ),
  );
}
