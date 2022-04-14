import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostEvent {
  final String description;
  final String title;
  final String locationBased;
  final String latitude;
  final String longitude;
  final String hostID;
  final String maxPeople;
  final String minPeople;
  final String startEvent;
  final String hasStarted;

  const PostEvent(
      {required this.description,
      required this.title,
      required this.locationBased,
      required this.latitude,
      required this.longitude,
      required this.hostID,
      required this.maxPeople,
      required this.minPeople,
      required this.startEvent,
      required this.hasStarted});

  factory PostEvent.fromJson(Map<String, dynamic> json) {
    return PostEvent(
      description: json['description'],
      title: json['title'],
      locationBased: json['locationBased'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      hostID: json['hostID'],
      maxPeople: json['maxPeople'],
      minPeople: json['minPeople'],
      startEvent: json['startEvent'],
      hasStarted: json['hasStarted'],
    );
  }
}

Future<PostEvent> createPostEvent(
  String description,
  String title,
  String locationBased,
  String latitude,
  String longitude,
  String hostId,
  String maxPeople,
  String minPeople,
  String startEvent,
  String hasStarted,
) async {
  print('result: ');

  final response = await http.post(
    Uri.parse(
        'http://office.pepr.com:25252/Event?description=$description&title=$title&locationbased=$locationBased&latitude=$latitude&longitude=$longitude&hostid=$hostId&maxPeople=$maxPeople&minPeople=$minPeople&startevent=$startEvent&hasstarted=$hasStarted'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('result: ' + jsonDecode(response.body));
    return PostEvent.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print('resultti: ' + jsonDecode(response.body));
    throw Exception('Failed to create album.');
  }
}
