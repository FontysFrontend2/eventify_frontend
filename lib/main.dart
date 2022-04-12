import 'package:eventify_frontend/create_event/create_event_view.dart';
import 'package:eventify_frontend/create_event/select_location.dart';
import 'package:eventify_frontend/feed/homefeed_view.dart';
import 'package:eventify_frontend/chat/event_chat/chatfeed_view.dart';
import 'package:eventify_frontend/login/login_view.dart';
import 'package:eventify_frontend/login/registeration_view.dart';
import 'package:eventify_frontend/map/map_view.dart';
import 'package:eventify_frontend/profile/profile_view.dart';
import 'package:eventify_frontend/event/eventcard_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile/themes.dart';

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
  bool settings = false;

  late SharedPreferences prefs;
  late bool isPlatformDark;

  retrieve() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("darkMode") == "true") {
        isPlatformDark = true;
        initTheme = isPlatformDark ? Themes.dark : Themes.light;
      } else {
        isPlatformDark = false;
        initTheme = isPlatformDark ? Themes.dark : Themes.light;
      }
    });
  }

  @override
  void initState() {
    retrieve();
    super.initState();
  }

  var initTheme;

  // State määrittää näytettävän näkymän
  void _stateCounter(int i) {
    retrieve();
    setState(() {
      _state = i;
      if (i > 2) {
        _navState = 1;
      } else {
        _navState = _state;
      }
    });
  }
  // code here

  static const List<Widget> _widgetOptions = <Widget>[
    Expanded(flex: 2, child: ChatFeedView()),
    Expanded(flex: 2, child: HomeFeedView()),
    Expanded(flex: 2, child: MapView()),
    Expanded(flex: 2, child: LoginView()),
    Expanded(flex: 2, child: RegisterationView()),
    Expanded(flex: 2, child: CreateEventView()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: initTheme,
        home: Builder(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                      title: const Text('Eventify'),
                      flexibleSpace: SafeArea(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 140,
                              ),
                              IconButton(
                                  alignment: Alignment.center,
                                  onPressed: () => {
                                        _navState = _state,
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilePage())).then(
                                            (_) => _stateCounter(_navState)),
                                      },
                                  icon: Image.asset("assets/images/user.png",
                                      color: Colors.amber)),
                              SizedBox(width: 20),
                              SizedBox(width: 140, child: TestButtons(context)),
                            ]),
                      )),

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
                        if (_state != 1) {
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
                      ]))),
                )));
  }

  Widget TestButtons(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.grey,
          width: 40,
          child: TextButton(
              onPressed: () => _stateCounter(3),
              child: Text('login',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
        ),
        Container(
          color: Colors.amber,
          width: 40,
          child: TextButton(
              onPressed: () => _stateCounter(4),
              child: Text('register',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
        ),
        Container(
          color: Colors.brown,
          width: 40,
          child: TextButton(
              onPressed: () => _stateCounter(5),
              child: Text('create event',
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
        ),
      ],
    );
  }
}
