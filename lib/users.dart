import 'dart:async';
import 'package:flutter_app/database_helper.dart';

final String tableName = "users";

class Users {
  int id;
  String first_name;
  String last_name;
  String email;
  String date_service;

  Users();

  DatabaseHelper dbHelper = new DatabaseHelper.internal();

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['first_name'] = first_name;
    map['last_name'] = last_name;
    map['email'] = email;
    map['date_service'] = date_service; // Y, N

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    Users users = new Users();
    users.id = map["id"];
    users.first_name = map["first_name"];
    users.last_name = map["last_name"];
    users.email = map["email"];
    users.date_service = map["date_service"];
    return users;
  }

  Future<int> save(Users users) async {
    var dbClient = await this.dbHelper.getDb();
    var res = await dbClient.insert(tableName, users.toMap());
    return res;
  }

  Future<List<Map>> fetchAll() async {
    var dbClient = await this.dbHelper.getDb();
    var sql = '''
      SELECT * FROM $tableName
    ''';
    List<Map> res = await dbClient.rawQuery(sql, []);
    return res;
  }

  Future delete(int id) async {
    var dbClient = await this.dbHelper.getDb();
    var sql = '''
      DELETE FROM $tableName WHERE id=?
    ''';

    await dbClient.rawQuery(sql, [id]);
  }
}
