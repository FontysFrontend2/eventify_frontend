import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:eventify_frontend/profile/profile_view.dart';
import 'package:eventify_frontend/profile/user.dart';
import 'dart:math';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:fluttermoji/fluttermoji_assets/face/eyes/eyes.dart';
import 'package:fluttermoji/fluttermoji_assets/fluttermojimodel.dart';
import 'package:fluttermoji/fluttermoji_assets/style.dart';
import 'package:fluttermoji/fluttermoji_assets/top/hairStyles/hairStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

//edit profile information
// post/get into database later

String aaction = '';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  User user = UserInformation.myUser;

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
          child: Builder(
        builder: (context) => Scaffold(
          appBar: appBar(context),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 34),
            physics: BouncingScrollPhysics(),
            children: [
              Profile(
                path: user.path,
                edit: true,
                onClicked: () async {},
              ),
              const SizedBox(height: 25),
              TextFieldd(
                label: 'Name',
                text: user.name,
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldd(
                label: 'Email',
                text: user.email,
                onChanged: (email) {},
              ),
              const SizedBox(height: 24),
              TextFieldd(
                label: 'Password',
                text: changePassword(user),
                onChanged: (password) {},
              ),
              const SizedBox(height: 24),
              TextFieldd(
                label: 'Description',
                text: user.description,
                maxlines: 5,
                onChanged: (description) {},
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ProfilePage()));
                },
              ),
              FluttermojiCircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 100,
              ),
              Container(
                height: 35,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.edit),
                  label: Text("Customize"),
                  onPressed: () => Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => NewAvatar())),
                ),
              ),
            ],
          ),
        ),
      ));
}

class TextFieldd extends StatefulWidget {
  final int maxlines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldd({
    Key? key,
    this.maxlines = 1,
    required this.label,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  TextFielddState createState() => TextFielddState();
}

class TextFielddState extends State<TextFieldd> {
  late final TextEditingController controller;
  User user = UserInformation.myUser;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: widget.maxlines,
          ),
        ],
      );
}

void saveNewName(String old) {
  var newName = old;
  print(newName);
}

Future<String?> pree() async {
  final prefs = await SharedPreferences.getInstance();
  final String? action = prefs.getString('fluttermoji');
  aaction = prefs.getString('fluttermoji')!;
  print(prefs.getString('fluttermoji')!);
  return action;
}

class NewAvatar extends StatelessWidget {
  const NewAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: FluttermojiCircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                width: min(600, width * 0.85),
                child: Row(
                  children: [
                    Text(
                      'Customize avatar',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(),
                    FluttermojiSaveWidget(
                      onTap: () => {
                        pree(),
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                child: FluttermojiCustomizer(
                  scaffoldWidth: min(600, width * 0.85),
                  autosave: false,
                  theme: FluttermojiThemeData(
                    boxDecoration: BoxDecoration(boxShadow: [BoxShadow()]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
