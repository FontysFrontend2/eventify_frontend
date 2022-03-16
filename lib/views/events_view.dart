import 'package:flutter/material.dart';

class EventsView extends StatelessWidget {
  const EventsView();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueAccent,
        width: double.infinity,
        height: 100.0,
        padding: const EdgeInsets.all(10.0),
        child: const Align(
            alignment: Alignment.center,
            child: Text(
              'This is events view',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )));
  }
}
