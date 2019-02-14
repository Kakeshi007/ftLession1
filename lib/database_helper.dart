import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';
import 'dart:io' as io;

class DatabaseHelper {
  static Database _db;

  final _lock = new Lock();

  Future<Database> getDb() async {
    if (_db == null) {
      io.Directory directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path, 'bmi.db');

      await _lock.synchronized(() async {
        if (_db == null) {
          _db = await openDatabase(path, version: 2);
        }
      });
    }
    return _db;
  }

  DatabaseHelper.internal();
  String sqlCreateBMI = '''
    create table if not exists bmi(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INT,
      bmi INT,
      weight INT,
      height INT,
      date_service TEXT)
  ''';
  String sqlCreateUsers = '''
    create table if not exists users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      first_name TEXT,
      last_name TEXT,
      email TEXT,
      date_service TEXT)
  ''';

  Future<Null> initialDatabase() async {
    var dbClient = await getDb();
    await dbClient.rawQuery(sqlCreateBMI);
    await dbClient.rawQuery(sqlCreateUsers);
    print("created");
    return null;
  }
}
