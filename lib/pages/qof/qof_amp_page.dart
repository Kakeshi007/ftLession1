import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/pages/helper.dart';

class QOFAmpure extends StatefulWidget {
  String qofId;
  String qofName;
  String chwId;
  String chwName;

  QOFAmpure(this.qofId, this.qofName, this.chwId, this.chwName);

  @override
  _QOFAmpureState createState() => _QOFAmpureState();
}

class _QOFAmpureState extends State<QOFAmpure> {
  List items = [];
  ApiProvider apiProvider = new ApiProvider();
  Helper helper = new Helper();
  bool isLoding = true;
  final numberFormat = new NumberFormat("#,##0", "en-US");

  Future fetchQofChw() async {
    try {
      var response =
          await apiProvider.getQofScoreAmpur(widget.qofId, widget.chwId);
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
        title: Text('${widget.chwName}'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${widget.chwName} ${widget.qofName}',
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoding
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      var item = items[index];
                      return ListTile(
                        title: Text('${item['ampurname']}'),
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Text(
                                      numberFormat
                                          .format(double.parse(item['target'])),
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Text("/"),
                                Text(
                                  numberFormat
                                      .format(double.parse(item['result'])),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            new LinearPercentIndicator(
                              width: 140.0,
                              animation: true,
                              lineHeight: 5.0,
                              animationDuration: 1000,
                              percent: double.parse(item['pers']) / 100,
                              progressColor: Colors.green,
                              backgroundColor: Colors.red,
                            ),
                          ],
                        ),
                        leading: new CircularPercentIndicator(
                          radius: 40.0,
                          lineWidth: 4.0,
                          animation: true,
                          percent: double.parse(item['pers']) / 100,
                          center: new Text(
                            '${item['score']}',
                            style: new TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20.0,
                                color: helper
                                    .getColorScore(int.parse(item['score']))),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: helper
                              .getColorPercent(double.parse(item['pers'])),
                          backgroundColor: Colors.white,
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      );
                    },
                    itemCount: items != null ? items.length : 0,
                  ),
          ),
        ],
      ),
    );
  }
}
