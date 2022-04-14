import 'package:eventify_frontend/apis/controllers/event_controller.dart';
import 'package:eventify_frontend/chat/event_chat/chat_card_list.dart';
import 'package:flutter/material.dart';
import '../../apis/models/event_model.dart';

import 'chat_card_list.dart';

class ChatFeedView extends StatefulWidget {
  const ChatFeedView({Key? key}) : super(key: key);

  @override
  _ChatFeedViewState createState() => _ChatFeedViewState();
}

class _ChatFeedViewState extends State<ChatFeedView> {
  late Future<List> futureAllEventsData;

  @override
  void initState() {
    super.initState();
    futureAllEventsData = fetchAllEventsData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              color: Colors.amber,
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  /*IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),*/
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
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  "EVENTS",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 28,
                                  ),
                                ))),
                      ],
                    ),
                  ),
                  Card(
                      margin: EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 10.0),
                          child: Text(
                            "CHATROOMS",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 20,
                            ),
                          ))),
                ],
              ),
            ),
          ),
        ),
        body: FutureBuilder<List>(
            future: futureAllEventsData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Center(
                          child: ChatCardList(
                              id: int.parse("${snapshot.data![index].id}"),
                              title: "${snapshot.data![index].title}",
                              description:
                                  "${snapshot.data![index].description}",
                              dateTime: "${snapshot.data![index].startEvent}",
                              locationBased:
                                  "${snapshot.data![index].locationBased}"),
                        ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
