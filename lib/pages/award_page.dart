import 'package:flutter/material.dart';

class AwardPage extends StatefulWidget {
  @override
  _AwardPageState createState() => _AwardPageState();
}

class _AwardPageState extends State<AwardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('การออกรางวัล'),
      ),
      body: Text('award'),
    );
  }
}
