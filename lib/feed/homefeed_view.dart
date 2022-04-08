import 'package:flutter/material.dart';
import 'package:eventify_frontend/event/eventcard_shortview.dart';

class HomeFeedView extends StatelessWidget {
  const HomeFeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final d1 = [
      {
        'name': 'Tapahtuma1',
        'desc': 'Testitapahtuma',
        'long': 123.12,
        'lat': 123.12,
      },
      {
        'name': 'Tapahtuma2',
        'desc': 'Testitapahtuma',
        'long': 132.12,
        'lat': 111.12,
      }
    ];

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ...d1.map((e) {
            return EventCardShortView(e);
          }).toList(),
        ],
      ),
    );
  }
}

// open eventcard view = Column(children: const [Expanded(flex: 2, child: EventCardView('id'))])