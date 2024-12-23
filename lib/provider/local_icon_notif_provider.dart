import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalIconNotifProvider extends ChangeNotifier {
  String keyNotif = 'keynotif';

  bool _isActiveNotif = false;
  bool get isActiveNotif => _isActiveNotif;

  set isActiveNotif(bool value) {
    _isActiveNotif = value;
    notifyListeners();
  }

  Future<void> saveActiveNotiv(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyNotif, value);
    await loadActiveNotiv();
  }

  Future<void> loadActiveNotiv() async {
    final prefs = await SharedPreferences.getInstance();
    _isActiveNotif = prefs.getBool(keyNotif) ?? false;
    notifyListeners();
  }
}
