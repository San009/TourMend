import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../loginPage.dart';
import './customDialogBox.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences preferences;
  String userEmail;

  @override
  void initState() {
    super.initState();
    _getUserEmail();
  }

  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(28.260075, 83.970093), zoom: 13.0);

  GoogleMapController _mapController;

  final List<Marker> _markers = [
    Marker(
      position: LatLng(28.260075, 83.970093),
      markerId: MarkerId('intial_marker'),
      infoWindow: InfoWindow(
          title: "Gandaki College of Engineering and Science",
          snippet: 'G.C.E.S'),
    )
  ];

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

  Future<bool> _handleLogout() async {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            actionsPadding: EdgeInsets.all(8.0),
            buttonPadding: EdgeInsets.all(20.0),
            title: new Text(
              'LogOut?',
            ),
            content: new Text('Are you sure that you want to logout?'),
            actions: <Widget>[
              InkWell(
                onTap: () => Navigator.of(context).pop(false),
                child:
                    Text("Cancel", style: TextStyle(color: Colors.blueAccent)),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  preferences.remove('user_email');
                  preferences.clear();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                    (route) => false,
                  );
                },
                child:
                    Text("Logout", style: TextStyle(color: Colors.redAccent)),
              ),
            ],
          ),
        ) ??
        false;
  }

  _getUserEmail() async {
    preferences = await SharedPreferences.getInstance();
    userEmail = preferences.getString('user_email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          onMapCreated: (controller) =>
              setState(() => _mapController = controller),
          onTap: (position) {
            _mapController.animateCamera(CameraUpdate.newLatLng(position));
            _addMarker(position);
          },
          markers: _markers.toSet(),
        ),
        Positioned(
          top: 30,
          right: 15,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Search here"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          child: CustomDialogBox(
                            userEmail: userEmail,
                            logoutFunciton: _handleLogout,
                          ));
                    },
                    child: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: Colors.deepPurple,
                        child: Icon(
                          Icons.portrait,
                          size: 20.0,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
