import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  String _language = 'English';

  ThemeMode get themeMode => _themeMode;
  String get language => _language;
  bool get isDark => _themeMode == ThemeMode.dark;
  String get languageCode => _language == 'Arabic' ? 'ar' : 'en';

  void setTheme(ThemeMode mode) {
    if (mode == _themeMode) return;
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void setLanguage(String language) {
    if (language == _language) return;
    _language = language;
    notifyListeners();
  }
}
