import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocation extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const SelectLocation();

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<SelectLocation> {
  final Set<Marker> markerlist = new Set(); //markers for google map
  _MapScreenState();

  var locationMarker;
  var location = '';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: (GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: {if (locationMarker != null) locationMarker},
          onTap: _addMarker)),
      floatingActionButton: SizedBox(
          height: 120.0,
          width: 340,
          child: Column(children: [
            FloatingActionButton(
              onPressed: () {},
              child: const Text('Select'),
            ),
            Text(
              'SELECT THIS LOCATION FOR YOUR EVENT:\n' + location,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
            ),
          ])),
    );
  }

  void _addMarker(LatLng pos) {
    location = pos.toString();
    setState(() {
      locationMarker = Marker(
          markerId: const MarkerId('location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos);
    });
  }
}
