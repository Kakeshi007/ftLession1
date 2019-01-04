import 'package:flutter/material.dart';

class CheckLottoPage extends StatefulWidget {
  @override
  _CheckLottoPageState createState() => _CheckLottoPageState();
}

class _CheckLottoPageState extends State<CheckLottoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตรวจรางวัย'),
      ),
      body: Text('checklotto'),
    );
  }
}
