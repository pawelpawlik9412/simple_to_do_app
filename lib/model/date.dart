class Date {
  Date({this.fullDate, this.shortWeekdayName, this.dayNumber});

  String fullDate;
  String shortWeekdayName;
  int dayNumber;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['fullDate'] = fullDate;
    map['shortWeekdayName'] = shortWeekdayName;
    map['dayNumber'] = dayNumber;
    return map;
  }

  Date.fromMapObject(Map<String, dynamic> map) {
    this.fullDate = map['fullDate'];
    this.shortWeekdayName = map['shortWeekdayName'];
    this.dayNumber = map['dayNumber'];
  }
}
