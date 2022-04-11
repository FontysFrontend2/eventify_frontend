import 'package:flutter/material.dart';
import 'package:eventify_frontend/event/eventcard_shortview.dart';
import '../a_data/events_data.dart' as event_data;

class HomeFeedView extends StatefulWidget {
  const HomeFeedView({Key? key}) : super(key: key);

  @override
  HomeFeedState createState() => HomeFeedState();
}

class HomeFeedState extends State<HomeFeedView> {
  int state = 1;
  final events = event_data.eventsWithLocation;

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
      padding: const EdgeInsets.all(5.0),
      child: (state == 1)
          ? ListView(
              children: [
                ...events.map((e) {
                  return EventCardShortView(e);
                }).toList(),
              ],
            )
          : (Container()),
    );
  }
}
  


// open eventcard view = Column(children: const [Expanded(flex: 2, child: EventCardView('id'))])