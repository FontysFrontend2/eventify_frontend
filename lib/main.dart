import 'package:eventify_frontend/views/events_view.dart';
import 'package:eventify_frontend/views/home_view.dart';
import 'package:flutter/material.dart';
import 'views/map_view.dart';

/*void main() {
  runApp(MyApp());
}*/

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
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
              title: Text('My App'),
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
                // Näkymät: state 0 = home, state 1 = events, state 2 = map
                child: Column(
                    children: ([
                  _state == 0
                      ? (Expanded(flex: 2, child: homeView))
                      : _state == 1
                          ? (Expanded(flex: 2, child: eventsView))
                          : (Expanded(flex: 2, child: mapView)),

                  // Painikkeet alhaalla: events, home, map
                  Container(
                      color: Colors.orange,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => _stateCounter(0),
                                  child: const Text('HOME'),
                                ),
                                TextButton(
                                  onPressed: () => _stateCounter(1),
                                  child: const Text('EVENTS'),
                                ),
                                TextButton(
                                  onPressed: () => _stateCounter(2),
                                  child: const Text('MAP'),
                                )
                              ])))
                ])))));
  }
}
