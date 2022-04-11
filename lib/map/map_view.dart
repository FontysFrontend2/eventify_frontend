import 'package:eventify_frontend/event/eventcard_view.dart';
import 'package:eventify_frontend/map/map_styles.dart';
import 'package:eventify_frontend/models/all_events_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final bool dark;
  const MapView(this.dark);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Set<Marker> markerlist = new Set(); //markers for google map
  _MapViewState();
  bool _filtered = false;
  late Set<Marker> markers;

  @override
  void initState() {
    loadLocations();
    super.initState();
  }

  var _state = 'load';
  String _filterValue = 'INTERESTS';

  void selectEvent(String id) {
    setState(() {
      _state = id;
    });
  }

  List<Marker> allMarkers = [];
  loadLocations() async {
    List<AllEventsData> locations = [];
    locations = await fetchAllEventsData(); //we store the response in a list
    for (int i = 0; i < locations.length; i++) {
      LatLng latlng =
          new LatLng(locations[i].latitude!, locations[i].longitude!);
      this.allMarkers.add(Marker(
            markerId: MarkerId(locations[i].id.toString()),
            position: latlng,
            infoWindow: InfoWindow(
              //popup info
              title: locations[i].title,
              snippet: locations[i].description + ' tap to join',
              onTap: () => selectEvent(locations[i].id.toString()),
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ));
    }
    setState(() {
      _state = '';
    });
  }

  static const _initialCameraPosition =
      CameraPosition(target: LatLng(65.012615, 25.471453), zoom: 11.5);

  late GoogleMapController _googleMapController;
  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    if (widget.dark) {
      _googleMapController.setMapStyle(map_style_dark);
    }
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == 'load') {
      return CircularProgressIndicator();
    } else if (_state == '') {
      return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          body: GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _onMapCreated(controller),
            markers: Set<Marker>.of(allMarkers),
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
