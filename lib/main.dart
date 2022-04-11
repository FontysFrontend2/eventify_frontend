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

  save() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (isPlatformDark) {
        prefs.setString("darkMode", "false");
        isPlatformDark = false;
        initTheme = isPlatformDark ? Themes.dark : Themes.light;
      } else {
        prefs.setString("darkMode", "true");
        isPlatformDark = true;
        initTheme = isPlatformDark ? Themes.dark : Themes.light;
      }
      // print('dark?: ' + isPlatformDark.toString());
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
    print('prefs: ' + prefs.getString("darkMode").toString());
    initTheme = isPlatformDark ? Themes.dark : Themes.light;
    print('initheme: ' + isPlatformDark.toString());
    if (i <= 2) {
      _navState = i;
    }
    if (i == 2) {
      isPlatformDark ? i = i : i += 1;
    }
    setState(() {
      _state = i;
    });
  }
  // code here

  static const List<Widget> _widgetOptions = <Widget>[
    Expanded(flex: 2, child: ChatFeedView()),
    Expanded(flex: 2, child: HomeFeedView()),
    Expanded(flex: 2, child: MapView(true)),
    Expanded(flex: 2, child: MapView(false)),
    Expanded(flex: 2, child: ProfilePage()),
    Expanded(flex: 2, child: LoginView()),
    Expanded(flex: 2, child: RegisterationView()),
    Expanded(flex: 2, child: CreateEventView()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: initTheme,
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
                // select theme painike
                (_state == 1)
                    ? (TextButton(
                        onPressed: () => {
                          setState(() {
                            save();
                          })
                        },
                        child: const Text('Change theme',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            )),
                      ))
                    : (Column()),
                _widgetOptions.elementAt(_state),

                // TESTIPAINIKKEET
                // TÄSTÄ ALASPÄIN KAIKKI KOODI POISTUU MYÖHEMMIN!!!!!!!!!!!!!

                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  // event card painike
                  TextButton(
                    onPressed: () => _stateCounter(4),
                    child: const Text('Profile',
                        style: TextStyle(
                          //
                          fontSize: 10, //
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  // login painike
                  TextButton(
                    onPressed: () => _stateCounter(5),
                    child: const Text('login',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  // register painike
                  TextButton(
                    onPressed: () => _stateCounter(6),
                    child: const Text('register',
                        style: TextStyle(
                          fontSize: 10, //
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  TextButton(
                    onPressed: () => _stateCounter(7),
                    child: const Text('Create Event',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ]),

                // create event painike
              ]))),

          // TÄHÄN ASTI POISTUU MOLEMMAT ROWIT!
        ));
  }
}
