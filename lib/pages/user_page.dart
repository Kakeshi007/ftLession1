import 'package:flutter/material.dart';
import 'package:flutter_app/pages/personadd_page.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายชื่อนักเรียน'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PersonAddPage(),
                    fullscreenDialog: true));
              })
        ],
      ),
      body: Center(
        child: Text('รายชื่อนักเรียน'),
      ),
    );
  }
}
