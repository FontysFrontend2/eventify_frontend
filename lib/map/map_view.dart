import 'dart:developer';

import 'package:eventify_frontend/event/eventcard_shortview.dart';
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

  var _state = '';

  void selectEvent(String id) {
    setState(() {
      log(id);
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
    return Scaffold(
        body: Container(
            child: _state == ''
                ? (GoogleMap(
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _initialCameraPosition,
                    onMapCreated: (controller) =>
                        _googleMapController = controller,
                    markers: getmarkers(),
                  ))
                : (Column(children: const [
                    Expanded(flex: 2, child: EventCardView())
                  ]))));
  }

  Set<Marker> getmarkers() {
    //markers to place on map

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
    ];

    setState(() {
      var counter = 0;
      for (var element in markersFromApi) {
        log(element.toString());
        markerlist.add(Marker(
          //add first marker
          markerId: MarkerId(markersFromApi[counter]['id']),
          position: LatLng(markersFromApi[counter]['lat'],
              markersFromApi[counter]['long']), //position of marker
          infoWindow: InfoWindow(
            //popup info
            title: markersFromApi[counter]['title'],
            snippet: markersFromApi[counter]['snippet'] + ' tap to join',
            onTap: () => selectEvent('0'),
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));
        counter += 1;
      }
    });

    return markerlist;
  }
}
