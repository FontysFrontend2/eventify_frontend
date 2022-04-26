import 'dart:convert';

import 'package:eventify_frontend/apis/controllers/user_controller.dart';
import 'package:eventify_frontend/apis/models/user_model.dart';
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

import 'apis/controllers/test_login_controller.dart';
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
  bool _authState =
      false; // false: not logged in (show login), true: logged in (show application)
  int _navState = 1;
  bool settings = false;

  late UserData futureUserFromIdData;

  late SharedPreferences prefs;
  late bool isPlatformDark;

  void testLoginSkip() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("token")!.length > 20) {
        _authState = true;
      } else {
        _authState = false;
      }
      retrieve();
    });
  }

  retrieve() async {
    prefs = await SharedPreferences.getInstance();
// get user info from api. Get user ID later in any class from json.encode(prefs.getString("userID"));
    var testawt = await fetchTestToken();
    prefs.setString("token", testawt);
    print(testawt.toString());
    futureUserFromIdData = await fetchUserFromId(
        6); // Later this should be done when anbd only when login is done
    //String tring = json.encode(futureUserFromIdData);
    List<String> interestListFromIdData =
        futureUserFromIdData.interests.map((s) => s.toString()).toList();
    List<String> eventListFromIdData =
        futureUserFromIdData.events.map((s) => s.toString()).toList();
    prefs.setInt("userID", futureUserFromIdData.id);
    prefs.setString("userName", futureUserFromIdData.name);
    prefs.setString("userEmail", futureUserFromIdData.email);
    prefs.setStringList("userInterests", interestListFromIdData);
    prefs.setStringList("userEvents", eventListFromIdData);
    print(prefs.getInt("userID")!.toString() +
        prefs.getString("userName").toString() +
        prefs.getString("userEmail").toString() +
        prefs.getStringList("userInterests").toString() +
        prefs.getStringList("userEvents").toString());
    // Check theme
    setState(() {
      if (prefs.getString("darkMode") == "true") {
        isPlatformDark = true;
        initTheme = isPlatformDark ? Themes.dark : Themes.light;
      } else {
        isPlatformDark = false;
        initTheme = isPlatformDark ? Themes.dark : Themes.light;
      }
      _authState = true;
    });
  }

  @override
  void initState() {
    testLoginSkip();
    super.initState();
  }

  dynamic initTheme;

  // State määrittää näytettävän näkymän
  void _stateCounter(int i) {
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
        home: (_authState)
            ? (Builder(
                builder: (context) => Scaffold(
                      appBar: AppBar(
                          title: const Text('Eventify'),
                          flexibleSpace: SafeArea(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  SizedBox(child: TestButtons(context)),
                                  IconButton(
                                      alignment: Alignment.center,
                                      onPressed: () => {
                                            _navState = _state,
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfilePage())).then(
                                                (_) => {
                                                      retrieve(),
                                                      _stateCounter(_navState)
                                                    }),
                                          },
                                      icon: Image.asset(
                                          "assets/images/user.png",
                                          color: Colors.amber)),
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
                                retrieve();
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
                    )))
            : (skipAuth(BuildContext, context)));
  }

// TEST BUTTONS. WILL BE GONE AFTER IMPLEMETATION

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
      ],
    );
  }

  Widget skipAuth(BuildContext, context) {
    return Builder(
        builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Eventify'),
              flexibleSpace: SafeArea(
                child: TextButton(
                    onPressed: () => {(retrieve())},
                    child: Text("Skip Login",
                        style: TextStyle(color: Colors.amber))),
              ),
            ),
            body: Column(
              children: [Expanded(flex: 2, child: LoginView())],
            )));
  }
}
