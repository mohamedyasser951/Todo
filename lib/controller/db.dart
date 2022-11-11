import 'package:sqflite/sqflite.dart';
import 'package:todo/model/model.dart';

// late Database mydatabase;
// List<Map> savedData = [];

class DBhelper {
  // createDatabase() {
  //   openDatabase(
  //     'todo.db',
  //     version: 1,
  //     onCreate: (mydatabase, version) {
  //       print("database is created");
  //       mydatabase
  //           .execute(
  //               "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,title STRING,note TEXT,date STRING,startTime STRING,endTime STRING,remind INTEGER,repeat STRING,color INTEGER,isComplete INTEGER)")
  //           .then((value) {
  //         print("Table is created");
  //       }).catchError((e) => print(e.toString()));
  //     },
  //     onOpen: (db) async {
  //       print("database is opened");
  //       // getDataFromDataBase(db).then((value) {
  //       //   print("getting data when opened");

  //       // });
  //     },
  //   ).then((value) {
  //     mydatabase = value;
  //     getDataFromDataBase(mydatabase);
  //   });
  // }

  // static Future<int> insert(Tasks tasks) async {
  //   print("inserted fuction called");
  //   print(mydatabase);
  //   return await mydatabase.insert('tasks', tasks.toJson());
  // }

  // static Future getDataFromDataBase(database) async {
  //   print("gettimg data");
  //   return await database.rawQuery("SELECT * FROM tasks").then((value) {
  //     print(value.toString());
  //     savedData = value;
  //   });
  // }

  // void deleteDataFromDB({required int id}) async {
  //   await mydatabase
  //       .rawDelete("DELETE FROM tasks WHERE id = ?", [id]).then((value) async {
  //     getDataFromDataBase(mydatabase);
  //   });
  // }
}
