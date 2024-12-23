import 'package:flutter/material.dart';
import 'package:restaurant_app/data/services/local_hour_and_minute_service.dart';

class LocalHourAndMinuteProvider extends ChangeNotifier {
  final LocalHourAndMinuteService _service = LocalHourAndMinuteService();

  List<String> _hourAndMinute = [];
  List<String> get hourAndMinute => _hourAndMinute;

  String _message = "";
  String get message => _message;

  Future<void> getHourAndMinute() async {
    try {
      _hourAndMinute = await _service.getSavedHoureAndMinute();
      notifyListeners();
    } catch (error) {
      _message = "Failed to get Hour And Minute $error";
      notifyListeners();
    }
  }

  Future<void> saveHourAndMinute(String hour, String minute) async {
    try {
      await _service.saveHoureAndMinute(hour, minute);
      await getHourAndMinute();
      notifyListeners();
    } catch (error) {
      _message = "Failed to save Hour and Minute $error";
      notifyListeners();
    }
  }
}
