import 'package:flutter/material.dart';
import 'setting_page.dart';
import 'info_page.dart';

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
    person.showName();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100.0,
            color: Colors.blue,
          ),
          Container(
            height: 100.0,
            color: Colors.amber,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  height: 100.0,
                  color: Colors.red,
                ),
              ),
              Expanded(
                child: Container(
                  height: 100.0,
                  color: Colors.green,
                ),
              ),
            ],
          )
        ],
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
  showName() {
    print('Hi $name');
    print('sum = ${2 + 6}');
  }
}
