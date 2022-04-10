import 'package:eventify_frontend/chat/event_chat/chat_card_list.dart';
import 'package:flutter/material.dart';
import '../../models/all_events_model.dart';
import '/a_data/events_data.dart';

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
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "EVENTS",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 28,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "CHATROOMS",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 20,
                      backgroundColor: Colors.grey,
                    ),
                  ),
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
                                  "${snapshot.data![index].description}"),
                        ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
