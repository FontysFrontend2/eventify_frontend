import 'package:eventify_frontend/apis/controllers/interest_controller.dart';
import 'package:eventify_frontend/apis/models/interest_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class InterestsCheckBoxList extends StatefulWidget {
  const InterestsCheckBoxList();
  @override
  InterestsCheckBoxListState createState() => InterestsCheckBoxListState();
}

class InterestsCheckBoxListState extends State<InterestsCheckBoxList> {
  late Future<List<InterestData>> checkBoxListTileModel;
  late List copyList = [];
  late List checkBoxList = [];
  late ScrollController _controller;
  bool save_option = false;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    loadInterests();
    super.initState();
  }

  loadInterests() async {
    // Get marker image from assets and set marker size
    List<InterestData> interests = [];
    interests = await fetchAllInterestData();
    for (int i = 0; i < interests.length; i++) {
      checkBoxList.add({
        'interestId': interests[i].id,
        'name': interests[i].name,
        'description': interests[i].description,
        'isCheck': true
      });

      copyList.add({
        'interestId': interests[i].id,
        'name': interests[i].name,
        'description': interests[i].description,
        'isCheck': true
      });
    }
    print(checkBoxList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 200.0,
          child: RawScrollbar(
              controller: _scrollController,
              isAlwaysShown: true,
              thumbColor: Colors.redAccent,
              radius: Radius.circular(20),
              thickness: 10,
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (3 / 1),
                ),
                itemCount: checkBoxList.length,
                itemBuilder: (BuildContext context, int index) {
                  // ignore: unnecessary_new
                  return new Card(
                    //padding: EdgeInsets.all(10.0),

                    child: Column(
                      children: <Widget>[
                        CheckboxListTile(
                            activeColor: Colors.pink[300],
                            dense: true,
                            //font change
                            title: Text(
                              checkBoxList[index]["name"],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5),
                            ),
                            value: checkBoxList[index]["isCheck"]!,
                            onChanged: (bool? val) {
                              itemChange(val!, index);
                            })
                      ],
                    ),
                  );
                },
              ))),
      (save_option)
          ? Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.lightGreenAccent,
              child: TextButton(
                  onPressed: sendInterests,
                  child: Text('Save',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold))))
          : (Container())
    ]);
  }

  void itemChange(bool val, int index) {
    int a = 0;
    setState(() {
      checkBoxList[index]["isCheck"] = val;
      print(checkBoxList[index]["isCheck"].toString() +
          copyList[index]["isCheck"].toString());

      for (int i = 0; i < checkBoxList.length; i++) {
        if (checkBoxList[i]["isCheck"] != copyList[i]["isCheck"]) {
          a += 1;
          print(a);
        }
      }
      if (a == 0) {
        save_option = false;
      } else {
        save_option = true;
      }
      copyList[index]["isCheck"] = val;
    });
  }

  void sendInterests() {
    List sendList = [];
    setState(() {
      for (int i = 0; i < checkBoxList.length; i++) {
        if (checkBoxList[i]['isCheck'] == true) {
          sendList.add(checkBoxList[i]);
        }
      }
      String listString = '';
      for (int i = 0; i < sendList.length; i++) {
        listString += sendList[i]['interestId'].toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Processing Data: ' + listString),
      ));
      //postData(checkBoxListTileModel);
      save_option = false;
    });
  }
}

class CheckBoxListTileModel {
  int? interestId;
  String? name;
  String? description;
  bool? isCheck;

  CheckBoxListTileModel(
      {this.interestId, this.name, this.description, this.isCheck});
}
