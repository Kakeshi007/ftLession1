import 'package:flutter/material.dart';
import 'package:flutter_app/pages/personadd_page.dart';
import 'package:flutter_app/users.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List listUsers = [];
  bool isLoading = true;
  Users users = new Users();

  Future getUser() async {
    try {
      var res = await users.fetchAll();
      setState(() {
        listUsers = res;
      });
    } catch (error) {
      print(error);
      Fluttertoast.showToast(msg: 'เกิดข้อผิดพลาด');
    }
  }

  Future<void> removeUser(int id) async {
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
              onPressed: () async {
                try {
                  await users.delete(id);
                  Fluttertoast.showToast(msg: 'Delete complete.');
                  getUser();
                  Navigator.of(context).pop();
                } catch (error) {
                  print(error);
                  Fluttertoast.showToast(msg: 'เกิดข้อผิดพลาด');
                }
                // exit(0);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายชื่อนักเรียน'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () async {
                var res = await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PersonAddPage(),
                    fullscreenDialog: true));
                getUser();
              })
        ],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var item = listUsers[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              child: ListTile(
                title: Text('${item['first_name']}  ${item['last_name']}'),
                subtitle: Text('${item['email']}'),
                trailing: IconButton(
                    icon: Icon(
                      IconData(0xe9ac, fontFamily: 'iconmoon'),
                      color: Colors.red,
                    ),
                    onPressed: () {
                      removeUser(item['id']);
                    }),
              ),
            ),
          );
        },
        itemCount: listUsers != null ? listUsers.length : 0,
      ),
    );
  }
}
