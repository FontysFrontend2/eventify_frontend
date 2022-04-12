import 'package:eventify_frontend/a_data/interests_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class InterestsCheckBoxList extends StatefulWidget {
  const InterestsCheckBoxList();
  @override
  InterestsCheckBoxListState createState() => InterestsCheckBoxListState();
}

class InterestsCheckBoxListState extends State<InterestsCheckBoxList> {
  List<CheckBoxListTileModel> checkBoxListTileModel =
      CheckBoxListTileModel.getUsers();
  List<CheckBoxListTileModel> copyList = CheckBoxListTileModel.getUsers();
  late ScrollController _controller;
  bool save_option = false;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('equals: ' + listEquals(checkBoxListTileModel, copyList).toString());
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
                itemCount: checkBoxListTileModel.length,
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
                              checkBoxListTileModel[index].title!,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5),
                            ),
                            value: checkBoxListTileModel[index].isCheck,
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
    setState(() {
      checkBoxListTileModel[index].isCheck = val;

      int a = 0;
      for (int i = 0; i < checkBoxListTileModel.length; i++) {
        if (checkBoxListTileModel[i].isCheck != copyList[i].isCheck) {
          a += 1;
        }
      }
      if (a == 0) {
        save_option = false;
      } else {
        save_option = true;
      }
    });
  }

  void sendInterests() {
    List<CheckBoxListTileModel> sendList = [];
    for (int i = 0; i < checkBoxListTileModel.length; i++) {
      if (checkBoxListTileModel[i].isCheck == true) {
        sendList.add(checkBoxListTileModel[i]);
      }
    }
    String listString = '';
    for (int i = 0; i < sendList.length; i++) {
      listString += sendList[i].interestId.toString();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Processing Data: ' + listString),
    ));
    //postData(checkBoxListTileModel);
  }
}

class CheckBoxListTileModel {
  int? interestId;
  String? title;
  bool? isCheck;

  CheckBoxListTileModel({this.interestId, this.title, this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(interestId: 1, title: "Football", isCheck: true),
      CheckBoxListTileModel(interestId: 2, title: "Gaming", isCheck: false),
      CheckBoxListTileModel(interestId: 3, title: "Studying", isCheck: false),
      CheckBoxListTileModel(interestId: 4, title: "Swimming", isCheck: false),
      CheckBoxListTileModel(interestId: 5, title: "Drinking", isCheck: false),
      CheckBoxListTileModel(interestId: 6, title: "Golf", isCheck: true),
      CheckBoxListTileModel(interestId: 7, title: "Airsoft", isCheck: true),
      CheckBoxListTileModel(interestId: 8, title: "Beach Ball", isCheck: false),
      CheckBoxListTileModel(interestId: 9, title: "CS GO", isCheck: false),
      CheckBoxListTileModel(
          interestId: 4, title: "League Of Legends", isCheck: false),
      CheckBoxListTileModel(interestId: 10, title: "Coding", isCheck: false),
      CheckBoxListTileModel(interestId: 11, title: "Hacking", isCheck: true),
      CheckBoxListTileModel(interestId: 12, title: "Travelling", isCheck: true),
      CheckBoxListTileModel(interestId: 13, title: "Bars", isCheck: false),
      CheckBoxListTileModel(interestId: 14, title: "Walking", isCheck: false),
      CheckBoxListTileModel(interestId: 15, title: "Shouting", isCheck: false),
      CheckBoxListTileModel(interestId: 16, title: "Talking", isCheck: false),
      CheckBoxListTileModel(
          interestId: 17, title: "Board Games", isCheck: true),
    ];
  }
}
