import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../a_data/events_data.dart';

class AllEventsData {
  final int id;
  final String description;
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

  const AllEventsData(
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

  factory AllEventsData.fromJson(Map<String, dynamic> json) {
    return AllEventsData(
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
Future<List<AllEventsData>> fetchAllEventsData() async {
  prefs = await SharedPreferences.getInstance();
  final response = await http
      .get(Uri.parse('http://office.pepr.com:25252/Event/getAllEvents'));
  if (response.statusCode == 200) {
    prefs.setString("allEvents", json.encode(eventsOfInterest));
    List jsonResponse = json.decode(response.body);
    print(response.statusCode);
    return jsonResponse
        .map((data) => new AllEventsData.fromJson(data))
        .toList();
  } else {
    List jsonResponseOffline = json.decode(prefs.getString("allEvents")!);
    return jsonResponseOffline
        .map((data) => new AllEventsData.fromJson(data))
        .toList();
  }
}
