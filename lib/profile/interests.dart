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
  @override
  Widget build(BuildContext context) {
    print('equals: ' + listEquals(checkBoxListTileModel, copyList).toString());
    return Column(children: [
      Container(
          height: 200.0,
          child: RawScrollbar(
              thumbColor: Colors.redAccent,
              radius: Radius.circular(20),
              thickness: 10,
              isAlwaysShown: true,
              child: GridView.builder(
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
                  onPressed: () => {},
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
      CheckBoxListTileModel(interestId: 5, title: "Golf", isCheck: true),
      CheckBoxListTileModel(interestId: 1, title: "Football", isCheck: true),
      CheckBoxListTileModel(interestId: 2, title: "Gaming", isCheck: false),
      CheckBoxListTileModel(interestId: 3, title: "Studying", isCheck: false),
      CheckBoxListTileModel(interestId: 4, title: "Swimming", isCheck: false),
      CheckBoxListTileModel(interestId: 5, title: "Drinking", isCheck: false),
      CheckBoxListTileModel(interestId: 5, title: "Golf", isCheck: true),
      CheckBoxListTileModel(interestId: 1, title: "Football", isCheck: true),
      CheckBoxListTileModel(interestId: 2, title: "Gaming", isCheck: false),
      CheckBoxListTileModel(interestId: 3, title: "Studying", isCheck: false),
      CheckBoxListTileModel(interestId: 4, title: "Swimming", isCheck: false),
      CheckBoxListTileModel(interestId: 5, title: "Drinking", isCheck: false),
      CheckBoxListTileModel(interestId: 5, title: "Golf", isCheck: true),
    ];
  }
}
