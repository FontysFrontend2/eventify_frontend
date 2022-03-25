import 'package:eventify_frontend/create_event/create_event_view.dart';
import 'package:eventify_frontend/event/events_view.dart';
import 'package:eventify_frontend/feed/homefeed_view.dart';
import 'package:eventify_frontend/chat/chat_view.dart';
import 'package:eventify_frontend/login/login_view.dart';
import 'package:eventify_frontend/login/registeration_view.dart';
import 'package:eventify_frontend/map/map_view.dart';
import 'package:eventify_frontend/profile/profile_view.dart';
import 'package:eventify_frontend/event/eventcard_view.dart';
import 'package:flutter/material.dart';

// sprintti2
void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _state = 0;

  // State määrittää näytettävän näkymän (0-5)
  void _stateCounter(int i) {
    setState(() {
      _state = i;
    });
  }
  // code here

  @override
  Widget build(BuildContext context) {
    // code here

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Eventify'),
            ),
            body: WillPopScope(
                // Takaisinnäppäimen hallinta, muista näkymistä vie homeen ja homesta sulkee sovelluksen
                onWillPop: () async {
                  if (_state != 0) {
                    setState(() {
                      _state = 0;
                    });
                    return false;
                  }
                  return true;
                },

                // Näkymät: state 0 = home, state 1 = events, state 2 = map, state 3 = profile, state 4 = event card,
                // state 5 = chat, state 6 = create event, state 7 = login, state 8 = register
                child: Column(
                    children: ([
                  _state == 0
                      ? (const Expanded(flex: 2, child: HomeFeedView()))
                      : _state == 1
                          ? (const Expanded(flex: 2, child: EventsView()))
                          : _state == 2
                              ? (Expanded(
                                  flex: 2,
                                  child: MapView(() => _stateCounter(4))))

                              // Below test buttons that should be implemented on their own pages
                              : _state == 3
                                  ? (const Expanded(
                                      flex: 2, child: ProfileView()))
                                  : _state == 4
                                      ? (const Expanded(
                                          flex: 2, child: EventCardView()))
                                      : _state == 5
                                          ? (const Expanded(
                                              flex: 2, child: ChatView()))
                                          : _state == 6
                                              ? (const Expanded(
                                                  flex: 2,
                                                  child: CreateEventView()))
                                              : _state == 7
                                                  ? (const Expanded(
                                                      flex: 2,
                                                      child: LoginView()))
                                                  : (const Expanded(
                                                      flex: 2,
                                                      child:
                                                          RegisterationView())),

                  // Painikkeet alhaalla: events, home, map
                  Container(
                      color: Colors.amber,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => _stateCounter(1),
                                  child: const Text('EVENTS',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                TextButton(
                                  onPressed: () => _stateCounter(0),
                                  child: const Text('HOME',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                TextButton(
                                  onPressed: () => _stateCounter(2),
                                  child: const Text('MAP',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                )
                              ]))),

                  // Testipainikkeet
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(
                      onPressed: () => _stateCounter(4),
                      child: const Text('Test: event card',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    TextButton(
                      onPressed: () => _stateCounter(5),
                      child: const Text('Test: joined event',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    TextButton(
                      onPressed: () => _stateCounter(7),
                      child: const Text('Test: loginscreen',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(
                        onPressed: () => _stateCounter(8),
                        child: const Text('Test registerscreen',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ))),
                    // profile painike
                    TextButton(
                      onPressed: () => _stateCounter(3),
                      child: const Text('Profile',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    // create event painike
                    TextButton(
                      onPressed: () => _stateCounter(6),
                      child: const Text('Create Event',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ])
                ])))));
  }
}
