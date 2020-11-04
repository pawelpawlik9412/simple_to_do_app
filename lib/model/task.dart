class Task {
  Task({this.id, this.fullDate, this.taskName, this.done});

  int id;
  String fullDate;
  String taskName;
  int done;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['fullDate'] = fullDate;
    map['taskName'] = taskName;
    map['done'] = done;
    return map;
  }

  Task.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.fullDate = map['fullDate'];
    this.taskName = map['taskName'];
    this.done = map['done'];
  }
}
