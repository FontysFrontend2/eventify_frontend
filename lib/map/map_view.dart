import 'dart:convert';

import 'package:eventify_frontend/map/map_screen.dart';
import 'package:eventify_frontend/models/all_events_model.dart';
import 'package:eventify_frontend/models/event_from_id.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView();

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late Future<List> futureAllEventsData;
  late Set<Marker> setter = {};
  late List list;
  Future<List> callAsyncFetch() => getMarkers();

  @override
  void initState() {
    futureAllEventsData = fetchAllEventsData();
    print('start');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return MapScreen(setter);
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<List> getMarkers() async {
    setState(() {
      Future<List>? setMarkers;
      setMarkers = fetchAllEventsData();
      ;
      print('sdasdjsoajdas odjasodsjad saodsao sa:');
      setMarkers.then((value) => {
            for (int i = 0; i < value.length; i++)
              {
                print('sdasdjsoajdas odjasodsjad saodsao sa:' +
                    value[i]['id'].toString()),
                setter.add(Marker(
                  markerId: MarkerId(value[i]['id'].toString()),
                  position: LatLng(value[i]['latitude'],
                      value[i]['longitude']), //position of marker
                  infoWindow: InfoWindow(
                    //popup info
                    title: value[i]['title'],
                    snippet: value[i]['description'] + ' tap to join',
                  ),
                  icon: BitmapDescriptor.defaultMarker, //Icon for Marker
                ))
              }
          });
    });
    return fetchAllEventsData();
  }
}
