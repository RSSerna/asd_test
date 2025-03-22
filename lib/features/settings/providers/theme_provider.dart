import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/app_theme.dart';

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
      debugPrint("Theme: $_currentTheme");
      notifyListeners();
    }
  }

  void _saveTheme() async {
    await prefs.setString(Constants.theme,
        AppTheme.themesByString[_currentTheme] ?? Constants.lightTheme);
  }
}
