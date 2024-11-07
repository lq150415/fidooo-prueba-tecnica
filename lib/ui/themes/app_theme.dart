import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch:Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: _barTheme,
        textTheme: _textTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        inputDecorationTheme: _inputTheme,
      );

  static InputDecorationTheme get _inputTheme => InputDecorationTheme(
        labelStyle: const TextStyle(color: Colors.black),
        floatingLabelStyle: const TextStyle(color: Colors.blue),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
      );

  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      );

  static TextTheme get _textTheme => const TextTheme(
        bodyLarge: TextStyle(color: Colors.black87, fontSize: 18),
        bodyMedium: TextStyle(color: Colors.black54, fontSize: 16),
        bodySmall: TextStyle(color: Colors.black45, fontSize: 14),
        titleLarge: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      );

  static AppBarTheme get _barTheme => const AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      );
}
