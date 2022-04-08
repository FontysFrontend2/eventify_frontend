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
  final Set markerlist = new Set();
  late List<dynamic> lista = [
    {'id': 1212, 'title': '', 'description': ''}
  ];
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
    return MaterialApp(
        title: 'Fetch Data Example',
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent,
        ),
        home: Scaffold(
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
                                    "${snapshot.data![index].description}")));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })));
  }

  Set getmarkers() {
// Get list items from api
    Future<List> markersFromApi = futureAllEventsData;

    print('mappi' + futureAllEventsData.toString());

    setState(() {
      Future<List> setMarkers;
      var counter = 0;

      markersFromApi.then((value) => {
            print('lenght' + value.length.toString()),
            for (int i = 0; i < value.length; i++)
              {
                print('valuetitle: ' + value[i].title),
                markerlist.add({
                  'id': value[i].id,
                  'title': value[i].title,
                  'description': value[i].description
                })
              }
          });
    });
    return markerlist;
  }
}
