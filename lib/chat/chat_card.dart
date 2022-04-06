import 'package:flutter/cupertino.dart';

class ChatCard {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatCard(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time});
}
