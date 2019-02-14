import 'package:flutter/material.dart';
import 'package:flutter_app/pages/helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PersonAddPage extends StatefulWidget {
  @override
  _PersonAddPageState createState() => _PersonAddPageState();
}

class _PersonAddPageState extends State<PersonAddPage> {
  @override
  final _formkey = GlobalKey<FormState>();
  Helper helper = new Helper();

  Future _saveData() async {
    if (_formkey.currentState.validate()) {
    } else {
      Fluttertoast.showToast(
          msg: "ข้อมูลไม่ครบ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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
