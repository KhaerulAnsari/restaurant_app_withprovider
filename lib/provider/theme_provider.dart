import 'package:flutter/material.dart';
import 'package:restaurant_app/data/services/local_theme_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  final LocalThemeCervice _localThemeService;
  ThemeProvider(this._localThemeService);

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    _localThemeService.saveThemeMode(themeMode);
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  void loadThemeMode() async {
    _themeMode = await _localThemeService.getSavedThemeMode();
    notifyListeners();
  }
}
