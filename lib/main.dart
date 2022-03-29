import 'package:eventify_frontend/create_event/create_event_view.dart';
import 'package:eventify_frontend/create_event/select_location.dart';
import 'package:eventify_frontend/event/events_view.dart';
import 'package:eventify_frontend/feed/homefeed_view.dart';
import 'package:eventify_frontend/chat/chat_view.dart';
import 'package:eventify_frontend/login/login_view.dart';
import 'package:eventify_frontend/login/registeration_view.dart';
import 'package:eventify_frontend/map/map_view.dart';
import 'package:eventify_frontend/profile/profile_view.dart';
import 'package:eventify_frontend/event/eventcard_view.dart';
import 'package:flutter/material.dart';

// sprint 3
void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _state = 1;
  int _navState = 1;

  // State määrittää näytettävän näkymän
  void _stateCounter(int i) {
    if (i <= 2) {
      _navState = i;
    }
    setState(() {
      _state = i;
    });
  }
  // code here

  static const List<Widget> _widgetOptions = <Widget>[
    Expanded(flex: 2, child: EventsView()),
    Expanded(flex: 2, child: HomeFeedView()),
    Expanded(flex: 2, child: MapView()),
    Expanded(flex: 2, child: ProfileView()),
    Expanded(flex: 2, child: EventCardView('')),
    Expanded(flex: 2, child: ChatView()),
    Expanded(flex: 2, child: CreateEventView()),
    Expanded(flex: 2, child: LoginView()),
    Expanded(flex: 2, child: RegisterationView()),
    Expanded(flex: 2, child: SelectLocation()),
  ];

  @override
  Widget build(BuildContext context) {
    // code here

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Eventify'),
      ),

      // bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navState,
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Events',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
            backgroundColor: Colors.purple,
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: _stateCounter,
      ),

      body: WillPopScope(
          // TAKAISINNÄPPÄINPAINIKKEEN HALLINTA, muista näkymistä vie homeen ja homesta sulkee sovelluksen
          onWillPop: () async {
            if (_state != _navState) {
              setState(() {
                _state = _navState;
              });
              return false;
            }
            return true;
          },
          child: Column(
              children: ([
            _widgetOptions.elementAt(_state),

            // TESTIPAINIKKEET
            // TÄSTÄ ALASPÄIN KAIKKI KOODI POISTUU MYÖHEMMIN!!!!!!!!!!!!!

            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // event card painike
              TextButton(
                onPressed: () => _stateCounter(4),
                child: const Text('event card',
                    style: TextStyle(
                      //
                      fontSize: 10, //
                      fontWeight: FontWeight.bold,
                    )),
              ),
              // joined event painike
              TextButton(
                onPressed: () => _stateCounter(5),
                child: const Text('joined event',
                    style: TextStyle(
                      //
                      fontSize: 10, //
                      fontWeight: FontWeight.bold,
                    )), //
              ), //
              // login painike
              TextButton(
                onPressed: () => _stateCounter(7),
                child: const Text('login',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              // register painike
              TextButton(
                  onPressed: () => _stateCounter(8),
                  child: const Text('register',
                      style: TextStyle(
                        fontSize: 10, //
                        fontWeight: FontWeight.bold,
                      ))),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // profile painike
              TextButton(
                onPressed: () => _stateCounter(3),
                child: const Text('Profile',
                    style: TextStyle(
                      fontSize: 10, //
                      fontWeight: FontWeight.bold,
                    )),
              ),
              // create event painike
              TextButton(
                onPressed: () => _stateCounter(6),
                child: const Text('Create Event',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              // select location painike
              TextButton(
                onPressed: () => _stateCounter(9),
                child: const Text('Select Location',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ])
          ]))),

      // TÄHÄN ASTI POISTUU MOLEMMAT ROWIT!
    ));
  }
}
