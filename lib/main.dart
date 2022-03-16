import 'package:eventify_frontend/views/events_view.dart';
import 'package:eventify_frontend/views/home_view.dart';
import 'package:eventify_frontend/views/joinedevent_view.dart';
import 'package:eventify_frontend/views/map_view.dart';
import 'package:eventify_frontend/views/profile_view.dart';
import 'package:eventify_frontend/views/eventcard_view.dart';
import 'package:flutter/material.dart';

/*void main() {
  runApp(MyApp());
}*/

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
                // Näkymät: state 0 = home, state 1 = events, state 2 = map, state 3 = profile, state 4 = event card, state 5 = joined event
                child: Column(
                    children: ([
                  _state == 0
                      ? (Expanded(
                          flex: 2,
                          child: Column(children: [
                            // profile painike
                            TextButton(
                              onPressed: () => _stateCounter(3),
                              child: const Text('Profile',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Expanded(flex: 2, child: homeView)
                          ])))
                      : _state == 1
                          ? (Expanded(flex: 2, child: eventsView))
                          : _state == 2
                              ? (Expanded(flex: 2, child: mapView))
                              : _state == 3
                                  ? (Expanded(flex: 2, child: profileView))
                                  : _state == 4
                                      ? (Expanded(
                                          flex: 2, child: eventcardView))
                                      : (Expanded(
                                          flex: 2, child: joinedeventView)),

                  // Painikkeet alhaalla: events, home, map ja event card
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
                  // Painike event card test and joined event test
                  // Event cardin voi myöhemmin avata mapista tai feedistä ennen liittymistä ja joined eventin kun on liittynyt eventtiin
                  Row(children: [
                    TextButton(
                      onPressed: () => _stateCounter(4),
                      child: const Text('Test Button for event card view',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    TextButton(
                      onPressed: () => _stateCounter(5),
                      child: const Text('Test Button for joined event view',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ])
                ])))));
  }
}
