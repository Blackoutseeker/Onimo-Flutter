import 'package:flutter/material.dart';

class DefaultTheme {
  static DefaultTheme instance = DefaultTheme();

  ThemeData themeData = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF166CED),
    ),
    scaffoldBackgroundColor: const Color(0xFF111111),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF111111),
      elevation: 0,
      toolbarHeight: 60,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF1E1E1E),
    ),
  );
}