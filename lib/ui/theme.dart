import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static const ThemeMode themeMode = ThemeMode.dark;

  static ThemeData themeData = ThemeData.dark().copyWith(
    // primaryColor: Colors.deepPurple,
    colorScheme: const ColorScheme.dark(
      primary: mainColor,
      secondary: secondaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: mainColorDark,
      centerTitle: true,
      elevation: 1.5,
    ),
    scaffoldBackgroundColor: mainColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
    ),
  );
}

// #22252D

// #292D36

// #272B33

// #ED6666

// #4B5EFC
