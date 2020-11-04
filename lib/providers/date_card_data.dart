import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todo/model/date.dart';

class DateCardData extends ChangeNotifier {
  DateTime getCurrentDay() {
    var today = DateTime.now();
    return today;
  }

  Date getDayDetail(DateTime dateTime) {
    return Date(
      fullDate: getFormatDate(dateTime),
      shortWeekdayName: getShortWeekDay(dateTime.weekday),
      dayNumber: dateTime.day,
    );
  }

  List getNextDays(int limit) {
    var today = getCurrentDay();
    List list = [getDayDetail(today)];
    int num = 1;
    for (var x = num; x < limit; x++) {
      var day = today.add(Duration(days: x));
      list.add(getDayDetail(day));
    }
    return list;
  }

  String getFormatDate(DateTime date) {
    var formatter = DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(date);
    return formatted;
  }

  String getShortWeekDay(int number) {
    switch (number) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tu';
      case 3:
        return 'Wed';
      case 4:
        return 'Th';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
    }
    return '';
  }
}
