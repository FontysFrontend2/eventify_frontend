import 'package:flutter/material.dart';

@override
Widget mapView = Container(
    color: Colors.greenAccent,
    width: double.infinity,
    height: 100.0,
    padding: const EdgeInsets.all(10.0),
    child: const Align(
        alignment: Alignment.center,
        child: Text(
          'This is map view',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        )));
