import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:todo/model/task.dart';

class DatabaseHelper {
  String id = 'id';
  String taskTable = "task_table";
  String fullDate = 'fullDate';
  String taskName = 'taskName';
  String done = 'done';

  static Database _database;

  DatabaseHelper._();

  static final DatabaseHelper db = DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  get _dbPath async {
    String documentsDirectory = await _localPath;
    return documentsDirectory + "$taskTable.db";
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<bool> dbExists() async {
    return File(await _dbPath).exists();
  }

  initDB() async {
    String path = await _dbPath;
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $taskTable ($id INTEGER PRIMARY KEY AUTOINCREMENT, $fullDate TEXT, $taskName TEXT, $done INTEGER)");
    });
  }

  closeDB() {
    if (_database != null) {
      _database.close();
    }
  }

  Future<int> insertTask(Task task) async {
    var db = await this.database;
    var result = await db.insert(taskTable, task.toMap());
    return result;
  }

  Future<List<Task>> getTaskForSelectedDay(
      BuildContext context, String day) async {
    var db = await this.database;
    var map = await db.rawQuery(
        "SELECT * FROM $taskTable WHERE $fullDate = '$day' ORDER BY $done");
    List<Task> taskList = [];

    for (int i = 0; i < map.length; i++) {
      taskList.add(
        Task(
          id: map[i]['id'],
          fullDate: map[i]['fullDate'],
          taskName: map[i]['taskName'],
          done: map[i]['done'],
        ),
      );
    }
    return taskList;
  }

  Future<int> updateTask(int taskId, int changedDone) async {
    var db = await this.database;
    int result = await db.rawUpdate(
        'UPDATE $taskTable SET $done = "$changedDone" WHERE $id = $taskId');
    return result;
  }

  Future<int> deleteTask(int taskId) async {
    var db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $taskTable WHERE $id =$taskId');
    return result;
  }

  Future<List> getListOfRowToDelete(String today) async {
    var db = await this.database;
    var result = await db.rawQuery("SELECT $fullDate FROM $taskTable");

    List<String> list = [];

    for (var x in result) {
      if (x[fullDate].compareTo(today) == -1) {
        if (list.contains(x[fullDate])) {
          break;
        } else {
          list.add(x[fullDate]);
        }
      }
    }
    return list;
  }

  Future<int> deleteTaskByFullDate(String fullDate) async {
    var db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $taskTable WHERE $fullDate =$fullDate');
    return result;
  }
}
