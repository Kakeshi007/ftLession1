import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper.dart';
import 'package:flutter_app/api_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Helper helper = new Helper();
  ApiProvider apiProvider = new ApiProvider();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  Future<Null> _handleGoogleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      print("display name=" + googleSignInAccount.email);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('google', googleSignInAccount.displayName);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.fill)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logoMOPH.png',
                width: 130.0,
              ),
              Text(
                'ระบบ KPI',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: controllerUser,
                          validator: (value) {
                            if (!helper.isEmail(value)) {
                              return 'Please enter email.';
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.white,
                              //prefixIcon: Icon(Icons.email),
                              labelText: 'ชื่อผู้ใช้งาน'),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: controllerPassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            }
                          },
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.white,
                              //prefixIcon: Icon(Icons.settings_ethernet),
                              labelText: 'รหัสผ่าน'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RaisedButton.icon(
                                color: Colors.greenAccent,
                                onPressed: () => _login(),
                                icon: Icon(Icons.send),
                                label: Text('Login')),
                            RaisedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.person),
                                label: Text('ลงทะเบียน'),
                                color: Colors.deepOrange),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton.icon(
                                color: Colors.redAccent,
                                onPressed: () => _handleGoogleSignIn(),
                                icon: Icon(
                                    IconData(0xea8d, fontFamily: 'iconmoon')),
                                label: Text('google')),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Future _login() async {
    if (_formKey.currentState.validate()) {
      try {
        var response = await apiProvider.getLogin(
            controllerUser.text, controllerPassword.text);

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse['ok']) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', jsonResponse['token']);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            print(jsonResponse['error']);
          }
        } else {
          print('error');
        }
      } catch (error) {
        print(error);
      }
//      Scaffold.of(context)
//          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
  }
}
