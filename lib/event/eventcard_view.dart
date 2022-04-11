import 'package:eventify_frontend/models/event_from_id.dart';
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

  late Future<EventFromIdData> futureEventData;

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
      child: FutureBuilder<EventFromIdData>(
          future: futureEventData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String dmy(String dtString) {
                final date = DateTime.parse(dtString);
                final format = DateFormat('d MMMM y - H:m');
                final clockString = format.format(date);

                return clockString;
              }

              return Column(
                children: [
                  Text(
                    snapshot.data!.title,
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tähän tietoa eventistä niin paljon kuin tarvis... gadsjhfkghsldkjfkjfhlkijsdhfkljhsdkljfhskjldhflkjshdlkfjhsdlkjfhlkjshdflkjhsdlkjfhlskjdhflkjshdlkjfhslkjdhflkjshdfjkhsdlkjhflksjhdfkljhsdlkjfhklshdfhlkjshdflkjhskjdlhflkjshdf' +
                        snapshot.data!.description.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    dmy(snapshot.data!.startEvent),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
