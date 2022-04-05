import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//all the interests will be put here when they have been decided
// post/get into the database later in a list
//

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({Key? key}) : super(key: key);
  @override
  SwitchButton createState() => SwitchButton();
}

class SwitchButton extends State<SwitchScreen>{
  bool isSwitched = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  bool isSwitched4 = false;

  var textValue1 = 'Coding';
  var textValue2 = 'Golf';
  var textValue3 = 'Tennis';
  var textValue4 = 'Call Of Duty';

  void toggleSwitch(bool value){
    if(isSwitched == false){
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  void toggleSwitch2(bool value2){
    if(isSwitched2 == false){
      setState(() {
        isSwitched2 = true;
      });
    } else {
      setState(() {
      isSwitched2 = false;
      });
    }
  }

  void toggleSwitch3(bool value2){
    if(isSwitched3 == false){
      setState(() {
        isSwitched3 = true;
      });
    } else {
      setState(() {
        isSwitched3 = false;
      });
    }
  }

  void toggleSwitch4(bool value2){
    if(isSwitched4 == false){
      setState(() {
        isSwitched4 = true;
      });
    } else {
      setState(() {
        isSwitched4 = false;
      });
    }
  }

  @override
  Widget build(BuildContext context){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            Transform.scale(
              scale: 1,
              child: Switch(
                onChanged: toggleSwitch,
                value: isSwitched,
                activeColor: Colors.blueAccent,
                activeTrackColor: Colors.lightBlueAccent,
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.black54,
              ),
            ),
            Text(textValue1,style:const TextStyle(fontSize: 15),
            ),

            Transform.scale(
              scale: 1,
              child: Switch(
                onChanged: toggleSwitch2,
                value: isSwitched2,
                activeColor: Colors.blueAccent,
                activeTrackColor: Colors.lightBlueAccent,
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.black54,
              ),
            ),
            Text(textValue2,style:const TextStyle(fontSize: 15),
            ),
            Transform.scale(
              scale: 1,
              child: Switch(
                onChanged: toggleSwitch3,
                value: isSwitched3,
                activeColor: Colors.blueAccent,
                activeTrackColor: Colors.lightBlueAccent,
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.black54,
              ),
            ),
            Text(textValue3,style:const TextStyle(fontSize: 15),
            ),
        ],
    ),
    Row(children: [
    Transform.scale(
    scale: 1,
    child: Switch(
    onChanged: toggleSwitch4,
    value: isSwitched4,
    activeColor: Colors.blueAccent,
    activeTrackColor: Colors.lightBlueAccent,
    inactiveTrackColor: Colors.grey,
    inactiveThumbColor: Colors.black54,
    ),
    ),
    Text(textValue4,style:const TextStyle(fontSize: 15),
    ),
    ],
    ),
        ],
    );
  }
}

