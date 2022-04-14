import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String email;
  final String description;
  final String path;
  final bool isDarkMode;
  final String password;

  const User({
    required this.name,
    required this.email,
    required this.description,
    required this.path,
    required this.isDarkMode,
    required this.password,
  });
}

String changePassword(User user) {
  String newPassword = '';
  String char = '*';
  for (var i = 0; i < user.password.length; i++) {
    newPassword += char;
  }
  return newPassword;
}

class UserInformation {
  static const myUser = User(
    name: 'Ismo Laitela',
    email: 'ismo.laitela@gmail.com',
    description: 'ismo asuu pihlajakadulla',
    path:
        'https://media.istockphoto.com/photos/fi/covid-19-tai-2019-ncov-koronaviruksen-k%C3%A4site-id1212142629',
    isDarkMode: false,
    password: 'moro',
  );
}
