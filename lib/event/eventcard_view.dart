import 'package:eventify_frontend/apis/controllers/event_controller.dart';
import 'package:eventify_frontend/apis/models/event_model.dart';
import 'package:eventify_frontend/chat/event_chat/event_location.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCardView extends StatefulWidget {
  final int id;

  const EventCardView(this.id);

  @override
  EventCardState createState() => EventCardState();
}

class EventCardState extends State<EventCardView> {
  int state = 1;

  late Future<EventData> futureEventData;

  @override
  void initState() {
    super.initState();
    futureEventData = fetchEventFromId(widget.id);
  }

  String dmy(String dtString) {
    final date = DateTime.parse(dtString);
    final format = DateFormat('d MMMM y - H:m');
    final clockString = format.format(date);

    return clockString;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      width: double.infinity,
      height: 100.0,
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder<EventData>(
          future: futureEventData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  //Event title
                  Text(
                    snapshot.data!.title,
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),

                  //Event date + startTime
                  Text(
                    dmy(snapshot.data!.startEvent),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),

                  //Joined / max
                  Text(
                    //snapshot.data!.members.length().toString()
                    '1/' + snapshot.data!.maxPeople.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  //Just a spacer container, any better solution?
                  Container(
                    width: double.infinity,
                    height: 20,
                  ),

                  //Event description
                  Text(
                    'Tähän tietoa eventistä niin paljon kuin tarvis... jhsdlkjfhklshdfhlkjshdflkjhskjdlhflkjshdf' +
                        snapshot.data!.description.toString(),
                    style: TextStyle(fontSize: 16),
                  ),

                  //Just a spacer container, any better solution?
                  Container(
                    width: double.infinity,
                    height: 20,
                  ),

                  //Small map to show location in small scale.
                  (snapshot.data!.locationBased)
                      ? (SizedBox(
                          height: 160,
                          child: EventLocation(snapshot.data!.latitude!,
                              snapshot.data!.longitude!),
                        ))
                      : (Container()),
                  Spacer(),

                  //Button to join/leave event
                  Align(
                    alignment: Alignment.bottomRight,
                    child: state == 1
                        ? TextButton(
                            onPressed: () {},
                            child: Text('Join Event'),
                          )
                        : TextButton(
                            child: Text('Leave Event'),
                            onPressed: () {},
                          ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
