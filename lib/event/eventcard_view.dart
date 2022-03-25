import 'package:flutter/material.dart';

class EventCardView extends StatelessWidget {
  final String? id;
  const EventCardView(this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreen,
        width: double.infinity,
        height: 100.0,
        padding: const EdgeInsets.all(10.0),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              'This is Eventcard view\n Event id is: ' + id!,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )));
  }
}
