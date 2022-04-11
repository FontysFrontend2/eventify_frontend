import 'package:flutter/material.dart';

import 'package:eventify_frontend/event/eventcard_shortview.dart';
import 'package:eventify_frontend/models/all_events_model.dart';

import '../event/eventcard_view.dart';

class HomeFeedView extends StatefulWidget {
  const HomeFeedView({Key? key}) : super(key: key);

  @override
  HomeFeedState createState() => HomeFeedState();
}

class HomeFeedState extends State<HomeFeedView> {
  int state = -1;

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

  void selectedEvent(int evId) {
    setState(() {
      state = evId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      child: (state == -1)
          ? FutureBuilder<List>(
              future: futureAllEventsData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Center(
                      child: EventCardShortView(
                        snapshot.data![index],
                        () => selectedEvent(snapshot.data![index].id),
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
          : (Expanded(
              flex: 2,
              child: EventCardView(
                state,
              ))),
    );
  }
}


// open eventcard view = Column(children: const [Expanded(flex: 2, child: EventCardView('id'))])