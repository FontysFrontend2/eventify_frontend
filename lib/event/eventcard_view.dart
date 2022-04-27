import 'package:eventify_frontend/apis/controllers/event_controller.dart';
import 'package:eventify_frontend/apis/controllers/user_controller.dart';
import 'package:eventify_frontend/apis/models/event_model.dart';
import 'package:eventify_frontend/chat/event_chat/event_location.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventCardView extends StatefulWidget {
  final int id;

  const EventCardView(this.id);

  @override
  EventCardState createState() => EventCardState();
}

class EventCardState extends State<EventCardView> {
  int state = 1;
  var _token;
  var _eventList;

  late Future<EventData> futureEventData;

  @override
  void initState() {
    super.initState();
    futureEventData = fetchEventFromId(widget.id);
    LoadData();
  }

  late SharedPreferences prefs;
  void LoadData() async {
    prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
    _eventList = prefs.getStringList("userEvents");
    print(_token);
    print(widget.id);
    if (_eventList!.contains(widget.id.toString())) {
      setState(() {
        print("contains");
        state = 2;
      });
    } else {
      setState(() {
        print("not contain");
        state = 1;
      });
    }
  }

  String dmy(String dtString) {
    final date = DateTime.parse(dtString);
    final format = DateFormat('d MMMM y - H:m');
    final clockString = format.format(date);

    return clockString;
  }

// handle join/leave button
  void HandleJoin(int joined) async {
    prefs = await SharedPreferences.getInstance();
    if (joined == 1) {
      _eventList.add(widget.id.toString());
      joinEvent(widget.id.toString(), _token);
      print("joining");
      setState(() {
        state = 2;
      });
    } else {
      leaveEvent(widget.id.toString(), _token);
      for (int i = 0; i < _eventList.length; i++) {
        //removeInterestDelete(unselect[i].toString(), userToken);
        print(_eventList[i]);
        if (_eventList[i].contains(widget.id.toString())) {
          print("removed" + _eventList[i].toString());
          _eventList.removeAt(i);
        }
      }
      setState(() {
        print("leaving");
        state = 1;
      });
    }
    prefs.setStringList("userEvents", _eventList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EventCard'),
      ),
      body: (Container(
        color: Colors.lightGreen,
        width: double.infinity,
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
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),

                    //Event date + startTime
                    Text(
                      dmy(snapshot.data!.startEvent),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),

                    //Joined / max
                    Text(
                      //snapshot.data!.members.length().toString()
                      '1/' + snapshot.data!.maxPeople.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                    // protetcted view when joined
                    (state == 2)
                        ? (Expanded(
                            flex: 2,
                            child: Container(
                                color: Colors.red,
                                child: Column(children: [
                                  Text(
                                      "THIS IS PROTETCTED VIEW YOU HAVE JOINED THIS EVENT")
                                ]))))
                        : (Container()),
                    //Button to join/leave event
                    Align(
                      alignment: Alignment.bottomRight,
                      child: state == 1
                          ? TextButton(
                              onPressed: () {
                                HandleJoin(state);
                              },
                              child: Text('Join Event'),
                            )
                          : TextButton(
                              child: Text('Leave Event'),
                              onPressed: () {
                                HandleJoin(state);
                              },
                            ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      )),
    );
  }
}
