import 'package:flutter/material.dart';

@override
Widget joinedeventView = Container(
    color: Colors.purple,
    width: double.infinity,
    height: 100.0,
    padding: const EdgeInsets.all(10.0),
    child: const Align(
        alignment: Alignment.center,
        child: Text(
          'This is joined event view',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        )));
