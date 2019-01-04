import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'setting_page.dart';
import 'info_page.dart';
import 'trends_page.dart';
import 'award_page.dart';
import 'chckLotto_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = 'Wiriya';
  int age = 0;
  double height = 185.0;
  bool isSuccess = true;
  List fruits = ['apple', 'mango', 'papaya']; //array
  Map fruit = {'apple': 'red', 'mango': 'yellow', 'papaya': 'green'};

  void showMessage() {
    Person person = new Person("person class");
    person.ShowName();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showConfirm() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ยืนยัน'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('ต้องการออกจากแอพหรือไม่'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'ไม่ใช่',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('ใช่'),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Lotto Sure'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage()));
              }),
          IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InfoPage(),
                        fullscreenDialog: true));
              })
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                'Wiriya',
                style: TextStyle(fontSize: 20.0),
              ),
              accountEmail: Text('wiriya.khetwit@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://scontent.fbkk12-1.fna.fbcdn.net/v/t1.0-1/c0.0.100.100/p100x100/29809_553005098059869_537060144_n.jpg?_nc_cat=106&_nc_ht=scontent.fbkk12-1.fna&oh=4fbbe2734f8f3374a1eb8e8e95c67e0d&oe=5C45A7AE"),
              ),
            ),
            ListTile(
              title: Text('แนวโน้ม'),
              subtitle: Text('ความน่าจะเป็นของรางวัลที่ออก'),
              leading: Icon(Icons.home),
              trailing: IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TrendsPage()));
                },
              ),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            ListTile(
              title: Text('การออกรางวัล'),
              subtitle: Text('รางวัลแต่ละงวด'),
              leading: Icon(Icons.account_balance),
              trailing: IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AwardPage()));
                },
              ),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            ListTile(
              title: Text('ตรวจหวย'),
              subtitle: Text('ตรวจสอบหวยที่ซื้อมา'),
              leading: Icon(Icons.search),
              trailing: IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckLottoPage()));
                },
              ),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            Divider(),
            ListTile(
              title: Text('ออกจากโปรแกรม'),
              trailing: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  _showConfirm();
                },
              ),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("test",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                      Text("test"),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "http://mangakakalot.com/themes/home/icons/logo.png"),
                  ),
                ],
              ),
              Divider(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.attach_file),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text("12315"),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => floatButtonClick(),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.home, color: Colors.white),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.account_balance,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.star, color: Colors.white),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                ],
              )
            ],
          )),
    );
  }

  floatButtonClick() {
    print("float button");
  }
}

class Person {
  String name;
  Person(this.name); //constructor
  ShowName() {
    print('Hi $name');
    print('sum = ${2 + 6}');
  }
}
