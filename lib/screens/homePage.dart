import 'dart:async';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../services/profileServices/getUserInfo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences preferences;
  String userEmail, userImage, userName;

  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(28.260075, 83.970093), zoom: 13.0);

  GoogleMapController _mapController;
  Circle _circle;
  final List<Marker> _markers = [
    Marker(
      position: LatLng(28.260075, 83.970093),
      markerId: MarkerId('intial_marker'),
      infoWindow: InfoWindow(
          title: "Gandaki College of Engineering and Science",
          snippet: 'G.C.E.S'),
    )
  ];

  final Location _location = Location();
  StreamSubscription _locationSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          onMapCreated: (controller) {
            _mapController = controller;
            _getCurrentLocation();
          },
          onTap: (position) {
            _mapController.animateCamera(CameraUpdate.newLatLng(position));
            _addMarker(position);
          },
          markers: _markers.toSet(),
          circles: Set.of((_circle != null) ? [_circle] : []),
        ),
      ]),
    );
  }

  void _addMarker(position) {
    var id = Random().nextInt(100);

    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId(id.toString()),
            position: position,
            infoWindow:
                InfoWindow(title: id.toString(), snippet: position.toString())),
      );
    });
  }

  void updateCircle(LocationData location) {
    LatLng latlng = LatLng(location.latitude, location.longitude);
    setState(() {
      _circle = Circle(
          circleId: CircleId('user_location'),
          radius: location.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void _getCurrentLocation() async {
    try {
      var location = await _location.getLocation();

      updateCircle(location);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription = _location.onLocationChanged.listen((location) {
        if (_mapController != null) {
          _mapController.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(location.latitude, location.longitude),
                  tilt: 0,
                  zoom: 17.0)));
          updateCircle(location);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }
}
