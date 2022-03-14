import 'package:flutter/material.dart';

@override
Widget homeView = Container(
    color: Colors.redAccent,
    width: double.infinity,
    height: 100.0,
    padding: const EdgeInsets.all(10.0),
    child: Align(
        alignment: Alignment.center,
        child: Text(
          'This is home view',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        )));
