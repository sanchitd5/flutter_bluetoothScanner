import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
export 'package:sqflite/sqflite.dart';

import '../../configurations/configurations.dart';

import '../../helpers/SQLite/DBcreation.dart';

import 'package:path/path.dart' as path;

class SQLiteHelper {
  static final SQLiteHelper _singleton = SQLiteHelper._privateConstructor();

  static final String _databaseName = Configurations().appTitle + ".db";
  static final int _databaseVersion = 1;
  static Database _database;

  factory SQLiteHelper() {
    return _singleton;
  }

  _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(path.join(dbPath, _databaseName),
        version: _databaseVersion, onCreate: (Database db, int version) {
      DBDefinition.onCreate(db, version);
    });
  }

  SQLiteHelper._privateConstructor() {
    _initDatabase();
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  static Future<void> execute(String query) async {
    final db = await _singleton.database;
    await db.transaction((action) async => await action.execute(query));
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await _singleton.database;
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final db = await _singleton.database;
    return db.query(tableName);
  }

  static Future<int> rawInsert(String query, List<dynamic> data) async {
    final db = await _singleton.database;
    return await db.rawInsert(query, data);
  }
  
  static Future<List> rawSelectAll(String table) async {
    final db = await _singleton.database;
    return db.rawQuery('SELECT * FROM $table');
  }

  static Future<int> delete(
      {@required int id, String table, String whereCondition}) async {
    Database db = await _singleton.database;
    if (null != whereCondition)
      return await db.delete(table, where: whereCondition, whereArgs: [id]);
    else
      return await db.delete(table, whereArgs: [id]);
  }

  static Future<int> queryRowCount(String table) async {
    Database db = await _singleton.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  static Future close() async => _singleton.database.then((database) {
        database.close();
      });
}
