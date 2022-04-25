import 'dart:convert';

import 'package:http/http.dart' as http;

Future fetchTestToken() async {
  final response = await http.get(Uri.parse(
      'http://office.pepr.com:25252/login?email=testemail1@test.com&password=testpassword'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return response.body;
  } else {
    print(response.statusCode);
    return response.body;
  }
}
