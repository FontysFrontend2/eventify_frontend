import 'package:eventify_frontend/event/eventcard_view.dart';
import 'package:flutter/material.dart';
import 'package:eventify_frontend/event/eventcard_shortview.dart';

class HomeFeedView extends StatelessWidget {
  const HomeFeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 100.0,
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.center,
        child: EventCardShortView(),
      ),
    );
  }
}

// open eventcard view = Column(children: const [Expanded(flex: 2, child: EventCardView('id'))])