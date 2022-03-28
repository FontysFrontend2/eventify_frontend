import 'package:flutter/material.dart';

class EventCardShortView extends StatelessWidget {
  var e1 = EventData();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      width: double.infinity,
      height: 100.0,
      padding: const EdgeInsets.all(10.0),
      child: Text(e1.name),
    );
  }
}

class EventData {
  String name = 'Tapahtuma1';
  String desc = 'Testitapahtuma';
  double long = 123.12;
  double lat = 123.12;
}
