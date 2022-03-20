import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final VoidCallback _selectHandler;

  // ignore: use_key_in_widget_constructors
  MapView(this._selectHandler);

  @override
  _MapScreenState createState() => _MapScreenState(this._selectHandler);
}

class _MapScreenState extends State<MapView> {
  final VoidCallback _selectHandler;
  _MapScreenState(this._selectHandler);

  void selectEvent() {
    _selectHandler();
  }

  static const _initialCameraPosition =
      CameraPosition(target: LatLng(65.012615, 25.471453), zoom: 11.5);

  late GoogleMapController _googleMapController;
  /*
  final Marker _event1 = Marker(
    markerId: const MarkerId('event1'),
    infoWindow: const InfoWindow(
        title: 'event1',
        snippet: 'This is example event number 1.\nJoin this event'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    position: const LatLng(65.012615, 25.471453),
  );

  final Marker _event2 = Marker(
    markerId: const MarkerId('event2'),
    infoWindow: const InfoWindow(
        title: 'event2',
        snippet: 'This is example event number 2.\nJoin this event'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    position: const LatLng(65.022615, 25.481453),
  );*/

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: {
            Marker(
              markerId: const MarkerId('event1'),
              infoWindow: InfoWindow(
                title: 'event1',
                snippet:
                    'This is example event number 1.\nJoin this event by tapping this',
                onTap: () => _selectHandler(),
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              position: const LatLng(65.012615, 25.471453),
            ),
            Marker(
              markerId: const MarkerId('event2'),
              infoWindow: InfoWindow(
                title: 'event1',
                snippet:
                    'This is example event number 2.\nJoin this event by tapping this',
                onTap: () => _selectHandler(),
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              position: const LatLng(65.022615, 25.481453),
            ),
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
          onPressed: () => _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition)),
          child: const Icon(Icons.center_focus_strong)),
    );
  }
}
