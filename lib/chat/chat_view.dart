import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';

import 'chat_message.dart';

class ChatView extends StatefulWidget {
  int id;
  ChatView({required this.id});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  List joined_event = [
    {
      "id": 0,
      "description": "Picnic at the park",
      "interests": [0],
      "members": [0],
      "title": "Picnic",
      "locationBased": true,
      "latitude": 65.012615,
      "longitude": 25.412615,
      "hostID": 0,
      "maxPeople": 10,
      "minPeople": 0,
      "startEvent": "2022-04-25T11:34:59.506Z",
      "hasStarted": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.id.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(children: [
          Align(
              child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 270,
                  width: double.infinity,
                  color: Colors.grey,
                  child: Column(children: [
                    Text(joined_event[0]["title"],
                        style: TextStyle(fontSize: 20)),
                    Text(joined_event[0]["description"],
                        style: TextStyle(fontSize: 20)),
                    Text('joo', style: TextStyle(fontSize: 20))
                  ]))),
          Expanded(
              child: Stack(
            children: <Widget>[
              ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType == "receiver"
                              ? Colors.grey.shade500
                              : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          messages[index].messageContent,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
