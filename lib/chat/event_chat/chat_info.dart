import 'dart:async';
import 'dart:convert';

import 'package:eventify_frontend/a_data/event_from_id.dart';
import 'package:eventify_frontend/chat/event_chat/chat_members.dart';
import 'package:eventify_frontend/chat/event_chat/event_location.dart';
import 'package:eventify_frontend/map/map_view.dart';
import 'package:eventify_frontend/models/event_from_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../a_data/events_data.dart';
import '../../create_event/select_location.dart';

class ChatInfo extends StatefulWidget {
  int id;
  String title;
  String description;
  ChatInfo({required this.id, required this.title, required this.description});

  @override
  _ChatInfoState createState() => _ChatInfoState();
}

class _ChatInfoState extends State<ChatInfo> {
  Set markerlist = new Set();
  late List<dynamic> lista = [
    {'id': 1212, 'title': '', 'description': ''}
  ];
  late Future futureAllEventsData;

  Map event = {'id': 1, 'title': 'title', 'description': 'desc'};
  @override
  void initState() {
    super.initState();
    //futureAllEventsData = fetchEventFromId(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool locationBased = true;

    return Align(
        child: Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            width: double.infinity,
            color: Colors.orange[100],
            child: Column(children: [
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(bottom: 10),
                child: Text(event["title"] as String,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.only(bottom: 10),
                color: Colors.orange[200],
                child: Text(event["description"] as String,
                    style: TextStyle(fontSize: 16)),
              ),
              Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(bottom: 10),
                  color: Colors.orange[200],
                  child: Text('Members: ' + event['members'].toString())),
              (locationBased)
                  ? (SizedBox(
                      height: 60,
                      child:
                          EventLocation(event['latitude'], event['longitude'])))
                  : (Container())
            ])));
  }

  Map getmarkers() {
// Get list items from api
    Future markersFromApi = futureAllEventsData;

    print('mappi' + futureAllEventsData.toString());
    Map setMarkers = {
      'id': 1,
      'title': 'value[i].title',
      'description': 'value[i].description'
    };

    setState(() {
      var counter = 0;
      markersFromApi.then((value) => {
            setMarkers = {
              'id': value.id,
              'title': value.title,
              'description': value.description
            }
          });
    });
    return setMarkers;
  }
}
