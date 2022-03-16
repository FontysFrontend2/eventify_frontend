import 'package:flutter/material.dart';

class RegisterationView extends StatelessWidget {
  const RegisterationView();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        width: double.infinity,
        height: 100.0,
        padding: const EdgeInsets.all(10.0),
        child: const Align(
            alignment: Alignment.center,
            child: Text(
              'This is registeration event view',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )));
  }
}
