import 'dart:convert';

import 'package:eventify_frontend/a_data/event_from_id.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventFromIdData {
  final int id;
  final String? description;
  final List? interests;
  final List? members;
  final String title;
  final bool locationBased;
  final double? latitude;
  final double? longitude;
  final int hostID;
  final int maxPeople;
  final int minPeople;
  final String startEvent;
  final bool hasStarted;

  const EventFromIdData(
      {required this.id,
      required this.description,
      required this.interests,
      required this.members,
      required this.title,
      required this.locationBased,
      required this.latitude,
      required this.longitude,
      required this.hostID,
      required this.maxPeople,
      required this.minPeople,
      required this.startEvent,
      required this.hasStarted});

  factory EventFromIdData.fromJson(Map<String, dynamic> json) {
    print('json' + json.toString());
    return EventFromIdData(
      id: json['id'],
      description: json['description'],
      interests: json['interests'],
      members: json['members'],
      title: json['title'],
      locationBased: json['locationBased'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      hostID: json['hostID'],
      maxPeople: json['maxPeople'],
      minPeople: json['minPeople'],
      startEvent: json['startEvent'],
      hasStarted: json['hasStarted'],
    );
  }
}

late SharedPreferences prefs;
Future<EventFromIdData> fetchEventFromId(int id) async {
  final response = await http
      .get(Uri.parse('http://office.pepr.com:25252/Event/GetEventByID?Id=$id'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return EventFromIdData.fromJson(jsonDecode(response.body));
  } else {
    return EventFromIdData.fromJson((eventFromId));
  }
}
