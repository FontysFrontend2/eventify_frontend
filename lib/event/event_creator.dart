import 'package:eventify_frontend/apis/controllers/user_controller.dart';
import 'package:eventify_frontend/apis/models/user_model.dart';
import 'package:eventify_frontend/create_event/create_event_view.dart';
import 'package:flutter/material.dart';

class EventCreator extends StatefulWidget {
  final int host;
  const EventCreator(this.host);

  @override
  EventCreatorState createState() => EventCreatorState();
}

class EventCreatorState extends State<EventCreator> {
  late Future<UserData> futureUserData;

  @override
  void initState() {
    super.initState();
    futureUserData = fetchUserFromId(widget.host);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueAccent,
        child: FutureBuilder<UserData>(
            future: futureUserData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!.email);
                return Row(
                  children: [
                    Text("Creator:  "),
                    Tab(
                        icon: new Image.asset(
                            "assets/images/profile_pictures/default_image.png")),
                    Text(snapshot.data!.name)
                  ],
                );
              } else {
                return Text("");
              }
            }));
  }
}
