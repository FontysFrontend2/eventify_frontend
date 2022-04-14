import 'package:eventify_frontend/apis/controllers/event_controller.dart';
import 'package:eventify_frontend/create_event/create_event_view.dart';
import 'package:flutter/material.dart';

import 'package:eventify_frontend/event/eventcard_shortview.dart';
import 'package:eventify_frontend/apis/models/event_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    print('refresh');
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
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      child: (state == -1)
          ? FutureBuilder<List>(
              future: futureAllEventsData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                      //refreshindicator to refresh feed
                      onRefresh: () async {
                        initState();
                        //staten settaaminen -1 ei päivitä feediä jostain syystä?
                      },
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Center(
                              child: EventCardShortView(
                                snapshot.data![index],
                                () => selectedEvent(snapshot.data![index].id),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(40, 40),
                                shape: const CircleBorder(),
                                primary: Colors.blue,
                                onPrimary: Colors.black,
                                shadowColor: Colors.white,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 30,
                              ),
                              onPressed: () => setState(() {
                                state = -2;
                              }),
                            ),
                          ),
                        ],
                      ));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })
          : (state == -2)
              ? (const Expanded(
                  flex: 2,
                  child: CreateEventView(),
                ))
              : (Expanded(
                  flex: 2,
                  child: EventCardView(
                    state,
                  ),
                )),
    );
  }
}


// open eventcard view = Column(children: const [Expanded(flex: 2, child: EventCardView('id'))])