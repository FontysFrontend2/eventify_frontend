import 'dart:convert';
import 'package:eventify_frontend/apis/offline_data/event_from_id.dart';
import 'package:eventify_frontend/apis/offline_data/events_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/event_model.dart';

late SharedPreferences prefs;
bool prefsNoData = true;

// Get all events from api
Future<List<EventData>> fetchAllEventsData() async {
  prefs = await SharedPreferences.getInstance();
  if (prefs.getString("allEvents") != null) {
    prefsNoData = false;
  } else {
    prefsNoData = true;
  }
  final response = await http
      .get(Uri.parse('http://office.pepr.com:25252/Event/getAllEvents'));
  if (response.statusCode == 200 && response.body != '[]') {
    prefs.setString("allEvents", json.encode(eventsOfInterest));
    List jsonResponse = json.decode(response.body);
    print('Request succeed with code 200: USING DATA FROM DATABASE');
    return jsonResponse.map((data) => new EventData.fromJson(data)).toList();
  } else {
    late List jsonResponseOffline;
    if (prefsNoData) {
      print(
          'Request failed and no data in Shared preferences: USING LOCAL DATA SAMPLES');
      jsonResponseOffline = eventsOfInterest;
      prefs.setString("allEvents", json.encode(eventsOfInterest));
    } else {
      print(
          'Request failed but there is recent data in Shared preferences: USING SHARED PREFERENCES');
      jsonResponseOffline = json.decode(prefs.getString("allEvents")!);
    }
    return jsonResponseOffline
        .map((data) => new EventData.fromJson(data))
        .toList();
  }
}

// Get event by id from api
Future<EventData> fetchEventFromId(int id) async {
  final response = await http
      .get(Uri.parse('http://office.pepr.com:25252/Event/GetEventByID?Id=$id'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return EventData.fromJson(jsonDecode(response.body));
  } else {
    return EventData.fromJson((eventFromId));
  }
}

// Post new Event to api
Future<EventData> createPostEvent(
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
    return EventData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print('resultti: ' + jsonDecode(response.body));
    throw Exception('Failed to create album.');
  }
}