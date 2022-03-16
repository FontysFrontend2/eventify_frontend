import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ChatView();

  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}
