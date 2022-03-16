import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView();

  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        width: double.infinity,
        height: 100.0,
        padding: const EdgeInsets.all(10.0),
        child: const Align(
            alignment: Alignment.center,
            child: Text(
              'This is home view',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )));
  }
}
