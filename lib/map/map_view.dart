import 'dart:developer';

import 'package:eventify_frontend/event/eventcard_view.dart';
import 'package:eventify_frontend/models/all_events_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../a_data/events_data.dart';

class MapView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const MapView();

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapView> {
  final Set<Marker> markerlist = new Set(); //markers for google map
  _MapScreenState();
  bool _filtered = false;

  late Future<List> futureAllEventsData;

  @override
  void initState() {
    futureAllEventsData = fetchAllEventsData();
    super.initState();
  }

  var _state = '';
  String _filterValue = 'INTERESTS';

  void selectEvent(String id) {
    setState(() {
      _state = id;
    });
  }

  static const _initialCameraPosition =
      CameraPosition(target: LatLng(65.012615, 25.471453), zoom: 11.5);

  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print('eventdata: ' + (futureEventData.data.title).toString());

    if (_state == '') {
      return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          body: GoogleMap(
            mapType: MapType.terrain,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            markers: getmarkers(),
            onMapCreated: (controller) => _googleMapController = controller,
          ),
          floatingActionButton: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: DropdownButton<String>(
                value: _filterValue,
                icon: const Icon(
                  Icons.arrow_drop_down_circle,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                onChanged: (String? newValue) {
                  setState(() {
                    _filterValue = newValue!;
                    if (_filterValue == 'INTERESTS') {
                      _filtered = false;
                    } else {
                      _filtered = true;
                    }
                  });
                },
                items: <String>['ALL', 'INTERESTS']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )));
    } else {
      return Scaffold(
          body: Column(
              children: [Expanded(flex: 2, child: EventCardView(_state))]));
    }
  }

  Set<Marker> getmarkers() {
// Get list items from api
    print('mappi' + futureAllEventsData.toString());

    setState(() {
      Future<List> markersFromApi = futureAllEventsData;

      List filteredMarkersFromApi = eventsOfInterestWithLocation;
      markerlist.clear();
      Future<List> setMarkers;
      var counter = 0;
      if (_filtered) {
        setMarkers = markersFromApi;
      } else {
        setMarkers = futureAllEventsData;
      }

      setMarkers.then((value) => {
            print('lenght' + value.length.toString()),
            for (int i = 0; i < value.length; i++)
              {
                print('valuetitle: ' + value[i].title),
                markerlist.add(Marker(
                  markerId: MarkerId(value.toString()),
                  position: LatLng(value[i].latitude,
                      value[i].longitude), //position of marker
                  infoWindow: InfoWindow(
                    //popup info
                    title: value[i].title,
                    snippet: value[i].description + ' tap to join',
                    onTap: () => selectEvent(value[i].id.toString()),
                  ),
                  icon: BitmapDescriptor.defaultMarker, //Icon for Marker
                ))
              }
          });
    });
    return markerlist;
  }
}
