import 'dart:typed_data';

import 'package:eventify_frontend/event/eventcard_view.dart';
import 'package:eventify_frontend/map/map_styles.dart';
import 'package:eventify_frontend/models/all_events_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

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
  late BitmapDescriptor customIcon;

  @override
  void initState() {
    loadmarkers();
    super.initState();
  }

  var _state = 'load';
  String _filterValue = 'INTERESTS';

  void selectEvent(String id) {
    setState(() {
      _state = id;
    });
  }

// Marker icon
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  List<Marker> allMarkers = [];

  loadmarkers() async {
    // Get marker image from assets and set marker size
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/jake.png', 120);
    List<AllEventsData> markers = [];
    markers = await fetchAllEventsData(); //we store the response in a list
    // Set markers on list
    for (int i = 0; i < markers.length; i++) {
      LatLng latlng = new LatLng(markers[i].latitude!, markers[i].longitude!);
      allMarkers.add(Marker(
          markerId: MarkerId(markers[i].id.toString()),
          position: latlng,
          infoWindow: InfoWindow(
            //popup info
            title: markers[i].title,
            snippet: markers[i].description + ' tap to join',
            onTap: () => selectEvent(markers[i].id.toString()),
          ),
          icon: BitmapDescriptor.fromBytes(markerIcon) //Icon for Marker
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
      return Center(child: CircularProgressIndicator());
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
          floatingActionButton: Card(
              color: widget.dark ? Colors.black : Colors.white,
              margin: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                  child: DropdownButton<String>(
                    value: _filterValue,
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
                  ))));
    } else {
      return Scaffold(
          body: Column(children: [Expanded(flex: 2, child: EventCardView(1))]));
    }
  }
}
