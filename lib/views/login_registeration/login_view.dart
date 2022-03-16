import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginView();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey,
        width: double.infinity,
        height: 100.0,
        padding: const EdgeInsets.all(10.0),
        child: const Align(
            alignment: Alignment.center,
            child: Text(
              'This is login event view',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )));
  }
}
