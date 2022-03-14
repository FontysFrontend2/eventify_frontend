import 'package:flutter/material.dart';

/*void main() {
  runApp(MyApp());
}*/

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // code here

  @override
  Widget build(BuildContext context) {
    // code here

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Text('Default text!'),
    ));
  }
}
