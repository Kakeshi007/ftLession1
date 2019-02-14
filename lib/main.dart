import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/database_helper.dart';

void main() async {
  DatabaseHelper databaseHelper = new DatabaseHelper.internal();
  await databaseHelper.initialDatabase();
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Mali',
            scaffoldBackgroundColor: Color(0xffe9ebee),
            primaryColor: Colors.blueGrey),
        title: 'Lottery Sure',
        home: LoginPage());
  }
}
