import 'package:asd_test/core/constants/constants.dart';
import 'package:flutter/material.dart';

enum AppThemeType {
  light,
  dark,
}

class AppTheme {
  static Map<AppThemeType, ThemeData> get themes => {
        AppThemeType.light: lightTheme,
        AppThemeType.dark: darkTheme,
      };

  static Map<AppThemeType, String> get themesByString => {
        AppThemeType.light: Constants.lightTheme,
        AppThemeType.dark: Constants.darkTheme,
      };

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue, // Example primary color
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue, //Example appbar color
      foregroundColor: Colors.white, // Example text color
    ),
    // ... other light theme properties (e.g., text styles, button styles)
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple, // Example primary color
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurple, //Example appbar color
      foregroundColor: Colors.white, // Example text color
    ),
    // ... other dark theme properties
  );
}
