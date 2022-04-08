import 'dart:convert';

import 'package:http/http.dart' as http;

class EventData {
  final int id;
  final String description;
  final List? interests;
  final List? members;
  final String title;
  final bool locationBased;
  final int latitude;
  final int longitude;
  final int hostID;
  final int maxPeople;
  final int minPeople;
  final String startEvent;
  final bool hasStarted;

  const EventData(
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

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['id'],
      description: json['description'],
      interests: json['interests'],
      members: json['members'],
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

Future<EventData> fetchEventData() async {
  final response = await http
      .get(Uri.parse('http://office.pepr.com:25252/Event/getAllEvents'));
  print('response: ' + response.body.toString());

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return EventData.fromJson(jsonDecode(response.body)[1]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
