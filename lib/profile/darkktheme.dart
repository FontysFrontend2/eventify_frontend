
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:eventify_frontend/profile/user.dart';

//get darkmode value from database

class Themes {
  static const first = Colors.blue;
  static final firstColor = Colors.blue.shade300;

  static final dark = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: firstColor,
    colorScheme: const ColorScheme.dark(primary: first),
    dividerColor: Colors.white,
  );

  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: firstColor,
    colorScheme: ColorScheme.light(primary: first),
    dividerColor: Colors.black,
  );
}

/*class ModeSwitcher extends StatefulWidget {
  const ModeSwitcher({Key? key}) : super(key: key);
  @override
  ThemeSwitch createState() => ThemeSwitch();
}


class ThemeSwitch extends State<ModeSwitcher>{
  bool switched = false;


  void toggleSwitch(bool value){
    if(switched == false){
      setState(() {
        switched = true;
      });
    } else {
      setState(() {
        switched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
        scale: 1,
        child: Switch(
          onChanged: toggleSwitch,
          value: switched,
          activeColor: Colors.blueAccent,
          activeTrackColor: Colors.lightBlueAccent,
          inactiveTrackColor: Colors.grey,
          inactiveThumbColor: Colors.black54,
        ),
      ),

      ],
    );
  }
*/