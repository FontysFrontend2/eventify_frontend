import 'package:flutter/material.dart';

class HomeFeedView extends StatelessWidget {
  const HomeFeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        width: double.infinity,
        height: 100.0,
        padding: const EdgeInsets.all(10.0),
        child: const Align(
            alignment: Alignment.center,
            child: Text(
              'This is home feed view',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )));
  }
}

// open eventcard view = Column(children: const [Expanded(flex: 2, child: EventCardView('id'))])