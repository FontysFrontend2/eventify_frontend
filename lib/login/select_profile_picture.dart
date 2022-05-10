import 'package:eventify_frontend/apis/controllers/interest_controller.dart';
import 'package:eventify_frontend/apis/controllers/user_controller.dart';
import 'package:eventify_frontend/apis/models/interest_model.dart';
import 'package:eventify_frontend/apis/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class selectProfilePicture extends StatefulWidget {
  const selectProfilePicture();
  @override
  selectProfilePictureState createState() => selectProfilePictureState();
}

class selectProfilePictureState extends State<selectProfilePicture> {
  String selected = "default_picture";
  late ScrollController _controller;
  List images = [
    "assets/images/profile_pictures/ava_1.png",
    "assets/images/profile_pictures/default_image.png",
    "assets/images/profile_pictures/default_image.png",
    "assets/images/profile_pictures/default_image.png",
    "assets/images/profile_pictures/default_image.png"
  ];

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
          height: 800,
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
                  childAspectRatio: (1 / 1),
                ),
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  // ignore: unnecessary_new
                  return new IconButton(
                    icon: Image.asset(images[index]),
                    onPressed: () => Navigator.pop(context, "samdksmkfsdm"),
                  );
                },
              ))),
    ]));
  }
}

class CheckBoxListTileModel {
  String? name;
  bool? isCheck;

  CheckBoxListTileModel({this.name, this.isCheck});
}
