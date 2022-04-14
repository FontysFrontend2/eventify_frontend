import 'dart:convert';

import 'package:eventify_frontend/a_data/event_from_id.dart';
import 'package:eventify_frontend/a_data/events_data.dart';
import 'package:eventify_frontend/apis/models/all_location_events_model.dart';
import 'package:eventify_frontend/apis/models/event_from_id.dart';
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
