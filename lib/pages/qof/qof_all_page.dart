import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api_provider.dart';
import 'qof_chw_page.dart';

class QOFAll extends StatefulWidget {
  @override
  _QOFAllState createState() => _QOFAllState();
}

class _QOFAllState extends State<QOFAll> {
  List items = [];
  ApiProvider apiProvider = new ApiProvider();
  bool isLoding = true;

  Future fetchQof() async {
    try {
      var response = await apiProvider.getQof();
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
    fetchQof();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Qof All'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'คะแนน QOF',
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

                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        QOFChangwat(item['id'], item['name'])));
                              },
                              title: Text(
                                '${item['name']}',
                                style: Theme.of(context).textTheme.body1,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Text(
                                  '${item['id']}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                          ),
                        );
                      },
                      itemCount: items != null ? items.length : 0,
                    ),
            )
          ],
        ));
  }
}
