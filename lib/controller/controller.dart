import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sqflite/sqflite.dart';
import 'package:todo/model/model.dart';
import 'package:todo/services/services.dart';
import 'package:todo/view/themes.dart';

class TaskController extends GetxController {
  @override
  void onInit() {
    createDatabase();
    super.onInit();
  }

  late Database mydatabase;
  late List savedData = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (mydatabase, version) {
        print("database is created");
        mydatabase
            .execute(
                "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,title STRING,note TEXT,date STRING,startTime STRING,endTime STRING,remind INTEGER,repeat STRING,color INTEGER,isComplete INTEGER)")
            .then((value) {
          print("Table is created");
        }).catchError((e) => print(e.toString()));
      },
      onOpen: (db) async {
        print("database is opened");

        getDataFromDataBase(db).then((value) {
          
          print("getting data after opened");
        });
      },
    ).then((value) {
      mydatabase = value;
      update();
    }).catchError((e) => print("somethine wrong${e.toString()}"));
  }

  Future insert(Tasks tasks) async {
    print("inserted fuction called");
    print(mydatabase);
    return await mydatabase.insert('tasks', tasks.toJson());
  }

  Future getDataFromDataBase(db) async {
    print("gettimg data");
    db.rawQuery("SELECT * FROM tasks").then((value) {
      print(value.toString());

      savedData = value;
      update();
    });
  }

  void deleteDataFromDB({required int id}) async {
    await mydatabase
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) async {
      getDataFromDataBase(mydatabase);
    });
  }

  Future addTask({required Tasks tasks}) async {
    return await insert(tasks).then((value) {
      getDataFromDataBase(mydatabase);
    });
  }
}
