import 'dart:developer';

import 'package:eventify_frontend/event/eventcard_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    if (_state == '') {
      return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          body: GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: getmarkers(),
          ),
          floatingActionButton: Container(
              color: Colors.deepOrange,
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: DropdownButton<String>(
                value: _filterValue,
                icon: const Icon(
                  Icons.arrow_drop_down_circle,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
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
    //markers to place on map
    log(_filtered.toString());

// Get list items from api
    List markersFromApi = [
      {
        'id': '1',
        'title': 'event 1',
        'snippet': 'this is event 1',
        'lat': 65.012615,
        'long': 25.412615
      },
      {
        'id': '2',
        'title': 'event 2',
        'snippet': 'this is event 2',
        'lat': 65.022615,
        'long': 25.481453
      },
      {
        'id': '3',
        'title': 'event 3',
        'snippet': 'this is event 3',
        'lat': 65.002616,
        'long': 25.441483
      },
      {
        'id': '4',
        'title': 'event 4',
        'snippet': 'this is event 4',
        'lat': 65.012625,
        'long': 25.482453
      },
    ];

    List filteredMarkersFromApi = [
      {
        'id': '1',
        'title': 'event 1',
        'snippet': 'this is event 1',
        'lat': 65.012615,
        'long': 25.412615
      },
      {
        'id': '3',
        'title': 'event 3',
        'snippet': 'this is event 3',
        'lat': 65.002616,
        'long': 25.441483
      },
    ];

    setState(() {
      markerlist.clear();
      List setMarkers;
      var counter = 0;
      if (_filtered) {
        log('filtered' + _filtered.toString());
        setMarkers = markersFromApi;
      } else {
        log('all' + _filtered.toString());
        setMarkers = filteredMarkersFromApi;
      }
      log('markers' + setMarkers.toString());
      for (var element in setMarkers) {
        String markervalue = setMarkers[counter]['id'];
        log(element.toString());
        markerlist.add(Marker(
          //add first marker
          markerId: MarkerId(setMarkers[counter]['id']),
          position: LatLng(setMarkers[counter]['lat'],
              setMarkers[counter]['long']), //position of marker
          infoWindow: InfoWindow(
            //popup info
            title: setMarkers[counter]['title'],
            snippet: setMarkers[counter]['snippet'] + ' tap to join',
            onTap: () => selectEvent(markervalue),
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));
        counter += 1;
      }
    });
    return markerlist;
  }
}
