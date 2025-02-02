import 'package:asd_test/core/constants/constants.dart';
import 'package:asd_test/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  AppThemeType _currentTheme = AppThemeType.light;
  final SharedPreferences prefs;

  AppThemeType get currentTheme => _currentTheme;

  ThemeProvider({required this.prefs}) {
    _loadTheme(); // Load saved theme when ThemeModel is created
  }

  void setTheme(AppThemeType theme) {
    _currentTheme = theme;
    _saveTheme(); // Save the theme to SharedPreferences
    notifyListeners();
  }

  void _loadTheme() async {
    String? themeName = prefs.getString(Constants.theme);
    if (themeName != null) {
      _currentTheme = themeName == Constants.darkTheme
          ? AppThemeType.dark
          : AppThemeType.light;
      print("TEMA: $_currentTheme");
      notifyListeners();
    }
  }

  void _saveTheme() async {
    await prefs.setString(Constants.theme,
        AppTheme.themesByString[_currentTheme] ?? Constants.lightTheme);
  }
}
