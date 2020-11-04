import 'package:flutter/cupertino.dart';
import 'package:todo/model/shared_pref.dart';
import 'package:todo/providers/date_card_data.dart';

class PreferencesData extends ChangeNotifier {
  static String today = DateCardData().getDayDetail(DateTime.now()).fullDate;

  static final _selectedDateCard =
      SharedPref(instanceName: 'date_card', deflautValue: today);

  Future<String> getDateCardPreferences() async {
    try {
      var x = await _selectedDateCard.read();
      checkDateCardPreferences(x);
      return x;
    } catch (e) {
      print(e);
    }
  }

  void checkDateCardPreferences(String preferences) async {
    if (preferences.compareTo(today) == -1) {
      safeDateCardPreferences(today);
    }
  }

  void safeDateCardPreferences(String value) {
    _selectedDateCard.save(value);
    notifyListeners();
  }

  void removeDateCardPreferences() {
    _selectedDateCard.remove();
    notifyListeners();
  }
}
