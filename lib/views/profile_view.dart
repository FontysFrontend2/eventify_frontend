import 'package:flutter/material.dart';

@override
Widget profileView = Container(
    color: Colors.white10,
    width: double.infinity,
    height: 100.0,
    padding: const EdgeInsets.all(10.0),
    child: const Align(
        alignment: Alignment.center,
        child: Text(
          'This is profile view',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        )));
