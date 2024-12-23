import 'package:shared_preferences/shared_preferences.dart';

class LocalHourAndMinuteService {
  final String keyHour = 'hour';
  final String keyMinute = 'minute';

  Future<List<String>> getSavedHoureAndMinute() async {
    final prefs = await SharedPreferences.getInstance();
    final hour = prefs.getString(keyHour);
    final minute = prefs.getString(keyMinute);

    if (hour != null && minute != null) {
      return [hour, minute];
    } else {
      return [];
    }
  }

  Future<void> saveHoureAndMinute(String hour, String minute) async {
    final prefs = await SharedPreferences.getInstance();
    if (hour.isNotEmpty && minute.isNotEmpty) {
      prefs.setString(keyHour, hour);
      prefs.setString(keyMinute, minute);
    } else {
      prefs.setString(keyHour, '00');
      prefs.setString(keyMinute, '00');
    }
  }
}
