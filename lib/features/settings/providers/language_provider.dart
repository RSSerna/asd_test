import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/constants.dart';
import '../../../core/l10n/l10n.dart';

class LanguageProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  Locale _locale = L10n.all[0];

  Locale get currentLocale => _locale;

  LanguageProvider({required this.prefs}) {
    _loadLanguage(); // Load saved theme when ThemeModel is created
  }

  void _loadLanguage() async {
    String? localeName = prefs.getString(Constants.language);
    if (localeName != null) {
      _locale =
          L10n.all.firstWhere((element) => element.languageCode == localeName);
    }
  }

  void setLocale(Locale locale) {
    _locale = locale;
    _saveLanguage(); // Save the theme to SharedPreferences
    notifyListeners();
  }

  void _saveLanguage() async {
    await prefs.setString(Constants.language, _locale.languageCode);
  }
}
