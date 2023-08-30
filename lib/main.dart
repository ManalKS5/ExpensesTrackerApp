import 'dart:html';

import 'package:flutter/material.dart';
import 'package:budget_app/widgets/expenses.dart';

var KColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var KDarkColorSheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
  );

void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: KDarkColorSheme, 
      cardTheme: const CardTheme().copyWith(
        color: KDarkColorSheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: KDarkColorSheme.primaryContainer,
          foregroundColor: KDarkColorSheme.onPrimaryContainer,
        ),
      ),
    ),
    theme: ThemeData().copyWith(
      colorScheme:KColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: KColorScheme.onPrimaryContainer,
        foregroundColor: KColorScheme.onPrimary,
      ),
      cardTheme: CardTheme().copyWith(
        color: KColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: KColorScheme.primaryContainer,
        ),
      ),
      textTheme: const TextTheme().copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: KColorScheme.onSecondaryContainer,
          fontSize: 17,
        ),
      ),
    ),
     //theme: ThemeData(useMaterial3: true),
    themeMode: ThemeMode.system,
    home: const Expenses(),

  ),
  );
}
