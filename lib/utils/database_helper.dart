import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/appointo.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String mainTable = 'AppointoTable';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnDate = 'date';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'appointo2.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $mainTable($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnDate TEXT)');
  }

  Future<int> saveApnt(Apppointo apnt) async {
    var dbClient = await db;
    var result = await dbClient.insert(mainTable, apnt.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $mainTable ($columnName, $columnDate) VALUES (\'${note.title}\', \'${note.description}\')');

    return result;
  }

  Future<List> getAllApnts() async {
    var dbClient = await db;
    var result = await dbClient.query(mainTable, columns: [columnId, columnName, columnDate]);
//    var result = await dbClient.rawQuery('SELECT * FROM $mainTable');

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $mainTable'));
  }

  Future<Apppointo> getApnto(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(mainTable,
        columns: [columnId, columnName, columnDate],
        where: '$columnId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $mainTable WHERE $columnId = $id');

    if (result.length > 0) {
      return new Apppointo.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteApnt(int id) async {
    var dbClient = await db;
    return await dbClient.delete(mainTable, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $mainTable WHERE $columnId = $id');
  }

  Future<int> updateApnt(Apppointo apnt) async {
    var dbClient = await db;
    return await dbClient.update(mainTable, apnt.toMap(), where: "$columnId = ?", whereArgs: [apnt.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $mainTable SET $columnName = \'${note.title}\', $columnDate = \'${note.description}\' WHERE $columnId = ${note.id}');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
