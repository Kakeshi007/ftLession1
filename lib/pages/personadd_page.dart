import 'package:flutter/material.dart';
import 'package:flutter_app/pages/helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/users.dart';

class PersonAddPage extends StatefulWidget {
  @override
  _PersonAddPageState createState() => _PersonAddPageState();
}

class _PersonAddPageState extends State<PersonAddPage> {
  @override
  final _formkey = GlobalKey<FormState>();
  Helper helper = new Helper();
  Users users = new Users();
  String sex = "F";

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  Future _saveData() async {
    if (_formkey.currentState.validate()) {
      users.first_name = firstNameController.text;
      users.last_name = lastNameController.text;
      users.email = emailController.text;

      try {
        await users.save(users);
        Fluttertoast.showToast(
          textColor: Colors.green,
          msg: "บันทึกข้อมูลสำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.of(context).pop();
      } catch (error) {
        print(error);
        Fluttertoast.showToast(
          textColor: Colors.red,
          msg: "ไม่สามารถบันทึกข้อมูลได้",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "ข้อมูลไม่ครบ",
        textColor: Colors.amberAccent[600],
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มนักเรียน'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'กรุณากรอกรายละเอียดนักเรียน',
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: firstNameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'กรุณาระบุชื่อ';
                              }
                            },
                            decoration: InputDecoration(
                                filled: true,
                                labelText: 'ชื่อ',
                                border: InputBorder.none,
                                fillColor: Colors.grey[10]),
                          ),
                          Divider(),
                          TextFormField(
                            controller: lastNameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'กรุณาระบุนามสกุล';
                              }
                            },
                            decoration: InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                labelText: 'นามสกุล',
                                fillColor: Colors.grey[10]),
                          ),
                          Divider(),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (!helper.isEmail(value)) {
                                return 'กรุณาระบุอีเมลล์';
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                labelText: 'อีเมลล์',
                                fillColor: Colors.grey[10]),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(IconData(
                                    0xe9dc,
                                    fontFamily: 'iconmoon',
                                  )),
                                  color: sex == "M" ? Colors.pink : Colors.grey,
                                  iconSize: 40.0,
                                  onPressed: () {
                                    setState(() {
                                      sex = "M";
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(
                                      IconData(0xe9dd, fontFamily: 'iconmoon')),
                                  color: sex == "F" ? Colors.pink : Colors.grey,
                                  iconSize: 40.0,
                                  onPressed: () {
                                    setState(() {
                                      sex = "F";
                                    });
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () => _saveData(),
                                child: Text('Save'),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
