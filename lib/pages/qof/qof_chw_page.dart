import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api_provider.dart';
import 'package:flutter_app/pages/qof/qof_amp_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QOFChangwat extends StatefulWidget {
  String qofId;
  String qofName;

  QOFChangwat(this.qofId, this.qofName);

  @override
  _QOFChangwatState createState() => _QOFChangwatState();
}

class _QOFChangwatState extends State<QOFChangwat> {
  List items = [];
  ApiProvider apiProvider = new ApiProvider();
  bool isLoding = true;

  Future fetchQofChw() async {
    try {
      var response = await apiProvider.getQofScoreChw(widget.qofId);
      if (response.statusCode == 200) {
        var jsonReseponse = json.decode(response.body);

        setState(() {
          isLoding = false;
          items = jsonReseponse;
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
    // TODO: implement initState
    super.initState();
    fetchQofChw();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.qofName}'),
      ),
      body: isLoding
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var item = items[index];

                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QOFAmpure(
                            widget.qofId,
                            widget.qofName,
                            item['chwcode'],
                            item['changwatname'])));
                  },
                  title: Text('${item['changwatname']}'),
                  subtitle: Text(
                      'เป้าหมาย : ${item['target']}, ผลลัพธ์ : ${item['result']}'),
                  leading: new CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 4.0,
                    animation: true,
                    percent: double.parse(item['pers']) / 100,
                    center: new Text(
                      '${item['pers']}',
                      style: new TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 10.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.green,
                    backgroundColor: Colors.amber,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                );
              },
              itemCount: items != null ? items.length : 0,
            ),
    );
  }
}
