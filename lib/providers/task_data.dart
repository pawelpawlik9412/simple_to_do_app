import 'package:flutter/cupertino.dart';
import 'package:todo/database/database_helper.dart';
import 'package:todo/model/task.dart';
import 'package:todo/providers/preferences_data.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/date_card_data.dart';

class TaskData extends ChangeNotifier {
  var _db = DatabaseHelper.db;
  static String today = DateCardData().getDayDetail(DateTime.now()).fullDate;

  void addTask(Task task) {
    _db.insertTask(task);
    notifyListeners();
  }

  Future<List<Task>> getTaskForCurrentDay(context) async {
    String day =
        await Provider.of<PreferencesData>(context).getDateCardPreferences();
    List<Task> x = await _db.getTaskForSelectedDay(context, day);
    return x;
  }

  void updateTask(int taskId, int changedDone) {
    _db.updateTask(taskId, changedDone);
    notifyListeners();
  }

  void deleteTask(int taskId) {
    _db.deleteTask(taskId);
    notifyListeners();
  }

  void deleteTaskByFullDate(String fullDate) async {
    await _db.deleteTaskByFullDate(fullDate);
    notifyListeners();
  }

  void deleteAllPastTask() async {
    var x = await _db.getListOfRowToDelete(today);
    for (var y in x) {
      await _db.deleteTaskByFullDate(y);
    }
    notifyListeners();
  }
}
