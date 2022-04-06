import 'package:eventify_frontend/chat/Chat_card_list.dart';
import 'package:flutter/material.dart';
import '../a_data/events_data.dart';

import 'chat_card.dart';

class ChatFeedView extends StatefulWidget {
  const ChatFeedView({Key? key}) : super(key: key);

  @override
  _ChatFeedViewState createState() => _ChatFeedViewState();
}

class _ChatFeedViewState extends State<ChatFeedView> {
  List data = eventsWithLocation;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "EVENTS",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pink[50],
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "CHAT ROOMS",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 20.0),
              children: [
                ...data.map((data) {
                  return ChatList(
                      id: data['id'],
                      title: data['title'],
                      description: data['description']);
                }).toList()
              ]),
        ],
      ),
    );
  }
}
