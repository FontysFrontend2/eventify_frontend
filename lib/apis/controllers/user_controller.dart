import 'dart:convert';
import 'package:eventify_frontend/apis/models/user_model.dart';
import 'package:eventify_frontend/apis/offline_data/user_data.dart';
import 'package:http/http.dart' as http;

Future<UserData> fetchUserFromId(int id) async {
  final response = await http
      .get(Uri.parse('http://office.pepr.com:25252/User/Details/?id=$id'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return UserData.fromJson(jsonDecode(response.body));
  } else {
    return UserData.fromJson((user));
  }
}
