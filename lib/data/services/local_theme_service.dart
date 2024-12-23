import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalThemeCervice {
  Future<ThemeMode> getSavedThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getString('themeMode');
    if (themeMode == 'dark') {
      return ThemeMode.dark;
    } else if (themeMode == 'light') {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }

  void saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    if (themeMode == ThemeMode.dark) {
      prefs.setString('themeMode', 'dark');
    } else if (themeMode == ThemeMode.light) {
      prefs.setString('themeMode', 'light');
    } else {
      prefs.setString('themeMode', 'system');
    }
  }
}
