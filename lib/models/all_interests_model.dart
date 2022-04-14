import 'dart:convert';

import 'package:http/http.dart' as http;

import '../a_data/interests_data.dart';

class AllInterestsData {
  final int id;
  final String name;
  final String description;
  final bool isCheck;

  const AllInterestsData(
      {required this.id,
      required this.name,
      required this.description,
      required this.isCheck});

  factory AllInterestsData.fromJson(Map<String, dynamic> json) {
    return AllInterestsData(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        isCheck: true);
  }
}

Future<List<AllInterestsData>> fetchAllInterestsData() async {
  final response =
      await http.get(Uri.parse('http://office.pepr.com:25252/Interaests'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((data) => new AllInterestsData.fromJson(data))
        .toList();
  } else {
    List interestsOffline = interests;
    return interestsOffline
        .map((data) => new AllInterestsData.fromJson(data))
        .toList();
  }
}
