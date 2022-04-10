import 'dart:convert';

import 'package:eventify_frontend/a_data/event_from_id.dart';
import 'package:eventify_frontend/chat/event_chat/chat_members.dart';
import 'package:eventify_frontend/chat/event_chat/event_location.dart';
import 'package:eventify_frontend/map/map_view.dart';
import 'package:flutter/material.dart';

import '../../a_data/events_data.dart';
import '../../create_event/select_location.dart';

class ChatInfo extends StatelessWidget {
  final int id;
  ChatInfo(this.id);

  @override
  Widget build(BuildContext context) {
    Map<String, Object?> event = eventsOfInterest[id];
    bool locationBased = event['locationBased'] as bool;

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
}
