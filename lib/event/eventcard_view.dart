import 'package:eventify_frontend/models/event_from_id.dart';
import 'package:flutter/material.dart';

class EventCardView extends StatefulWidget {
  final int id;
  const EventCardView(this.id);

  @override
  EventCardState createState() => EventCardState();
}

class EventCardState extends State<EventCardView> {
  int state = 1;

  late Future futureEventData;

  @override
  void initState() {
    super.initState();
    futureEventData = fetchEventFromId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      width: double.infinity,
      height: 100.0,
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder(
          future: futureEventData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Text(
                  'This is Eventcard view\n Event id is: ' +
                      widget.id.toString(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
