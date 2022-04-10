import 'dart:developer';

import 'package:eventify_frontend/event/eventcard_view.dart';
import 'package:eventify_frontend/models/all_events_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../a_data/events_data.dart';

class MapScreen extends StatefulWidget {
  //final Future<List> futureAllEventsData;
  final Set<Marker> dataa;
  MapScreen(this.dataa);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> markerlist = new Set(); //markers for google map
  _MapScreenState();
  bool _filtered = false;
  late Set<Marker> markers;

  @override
  void initState() {
    print('start');
    /*markers = getMarkers();*/
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
    /*print('eventdata: ' +
        (widget.futureAllEventsData
            .then((value) => value[0].title)
            .toString()));*/

    if (_state == '') {
      return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          body: GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: widget.dataa,
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
/*
  Set<Marker> getMarkers() {
    print('mappi' + widget.futureAllEventsData.toString());
    setState(() {
      Future<List> setMarkers;
      var counter = 0;
      setMarkers = widget.futureAllEventsData;
      print('sdasdjsoajdas odjasodsjad saodsao sa:');
      widget.futureAllEventsData.then((value) => {
            for (int i = 0; i < value.length; i++)
              {
                print('sdasdjsoajdas odjasodsjad saodsao sa:' +
                    value[i].id.toString()),
                markerlist.add(Marker(
                  markerId: MarkerId(value[i].id.toString()),
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
  }*/
}
