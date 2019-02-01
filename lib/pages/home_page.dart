import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/api_provider.dart';
import 'package:flutter_app/pages/qof/qof_all_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'setting_page.dart';
import 'info_page.dart';
//import 'trends_page.dart';
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

  String token = "";
  String email = "";
  String displayName = "";
  String photoUrl = "";

  List items = [];
  bool isLoding = true;

  ApiProvider apiProvider = ApiProvider();

  Future getInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      this.email = preferences.getString('email');
      this.displayName = preferences.getString('displayName');
      this.photoUrl = preferences.getString('photoURL');
    });
  }

  Future fetchUsers() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString('token');

      var response = await apiProvider.getApiUsers(token);

      if (response.statusCode == 200) {
        var jsonReseponse = json.decode(response.body);
        //print(jsonReseponse);
        setState(() {
          isLoding = false;
          items = jsonReseponse['rows'];
        });
      }
    } catch (error) {
      setState(() {
        isLoding = false;
      });
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    getInfo();
    fetchUsers();
  }

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
                this.displayName,
                style: TextStyle(fontSize: 20.0),
              ),
              accountEmail: Text(this.email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(this.photoUrl),
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
                      MaterialPageRoute(builder: (context) => QOFAll()));
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
      body: isLoding
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var item = items[index];

                return ListTile(
                  title: Text(
                      '${item['name']['title']} ${item['name']['first']} ${item['name']['last']}'),
                  subtitle: Text('${item['email']}'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item['picture']['thumbnail']),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                );
              },
              itemCount: items != null ? items.length : 0,
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
