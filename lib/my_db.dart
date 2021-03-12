import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'task.dart';

class DBProvider {
  /*DBProvider();
  static final DBProvider db = DBProvider();

  static Database _database;

  static const String nameTable = "TASKS";

  Future<Database> get database async {
    WidgetsFlutterBinding.ensureInitialized();
    if(_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }*/

  Database db;
  DBProvider(/*{this.db}*/);

  static const String nameTable = "TASKS";

  Future<Database> get database async {
    WidgetsFlutterBinding.ensureInitialized();
    if(db != null)
      return db;

    db = await initDB();
    return db;
  }

  initDB() async {
    
    Directory dbPath = await getApplicationDocumentsDirectory();
    
    //var dbPath = "/home/kostja/MyProgram/Flatter/on_Linux/bloc_list_builder";
    print("my_db initDB() dbPath == $dbPath");
    String path = join(dbPath.path, "BLoCListBuilder.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE IF NOT EXISTS $nameTable ("
          "id INTEGER PRIMARY KEY,"
          "position INTEGER,"
          "text TEXT,"
          "allTaskCount INTEGER,"
          "completedTaskCount INTEGER," 
          "completedTaskProcent REAL)");
      },/* onUpgrade: (Database db, int version) async {
        await db.execute("CREATE TABLE IF NOT EXISTS $nameTable ("
          "id INTEGER PRIMARY KEY,"
          
          "text TEXT,"
          "allTaskCount INTEGER,"
          "completedTaskCount INTEGER," 
          "completedTaskProcent REAL)");
      } */
    );
  }

  getTask(int id) async {
    print("my_db getTask() id == $id");
    final ndb = await database;
    var res = await ndb.query("$nameTable", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Task.fromMap(res.first) : Null;
  }

  Future<List<Task>> getAllTasks() async {
    final ndb = await database;
    print('getAllTasks()');
    var res = await ndb.query("$nameTable");
    print("my_db getAllTask() res == $res");
    List<Task> list = 
      res.isNotEmpty ? res.map((t) => Task.fromMap(t)).toList() : [];
    return list;
  }

  newTask(Task newTask) async {
    final ndb = await database;
    var table = await ndb.rawQuery("SELECT MAX(id)+1 as id FROM $nameTable");
    int id = table.first["id"];
    //if(id != null) {
    print("my_db newTask() id == $id");
    var raw = await ndb.rawInsert(
      "INSERT Into $nameTable (id,position,text,allTaskCount,completedTaskCount,completedTaskProcent)"
      " VALUES (?,?,?,?,?,?)",
      [id, newTask.position, newTask.text, newTask.allTaskCount, newTask.completedTaskCount, newTask.completedTaskProcent]);
    return raw;
    /*} else {
      print("my_db newTask() id == $id");
    var raw = await ndb.rawInsert(
      "INSERT Into $nameTable (id,position,text,allTaskCount,completedTaskCount,completedTaskProcent)"
      " VALUES (?,?,?,?,?,?)",
      [0, newTask.position, newTask.text, newTask.allTaskCount, newTask.completedTaskCount, newTask.completedTaskProcent]);
    return raw;
    }*/
  }

  updateTask(Task newTask) async {
    print("my_db updateTask() newTask == $newTask");
    final ndb = await database;
    var res = await ndb.update("$nameTable", newTask.toMap(),
      where: "id = ?", whereArgs: [newTask.id]);
    return res;
  }

  deleteTask(int id) async {
    print("my_db deleteTask() id == $id");
    final ndb = await database;
    return ndb.delete("$nameTable", where: "id = ?", whereArgs: [id]);
  }

}