import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import './loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/places.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences logindata;
  String username;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actionsPadding: EdgeInsets.all(10.0),
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit TourMend'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> _handleLogout() async {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('LogOut?'),
            content: new Text('Are you sure that you want to logout?'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("Cancel"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('user_email');
                  prefs.clear();

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text("Logout"),
              ),
            ],
          ),
        ) ??
        false;
  }

  static const TextStyle optionStyle = TextStyle(fontSize: 30);
  final _widgetOption = <Widget>[
    new PlacesPage(),
    Text(
      'Index 1: Maps',
      style: optionStyle,
    ),
    Text(
      'Index 2: Home',
      style: optionStyle,
    ),
    Text(
      'Index 2: News',
      style: optionStyle,
    ),
    Text(
      'Index 3: Event',
      style: optionStyle,
    ),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        appBar: new AppBar(
          title: Center(
              child: Text("TourMend", style: TextStyle(color: Colors.white))),
          actions: <Widget>[
            FlatButton(
                onPressed: () {},
                child: Icon(Icons.notifications, color: Colors.white)),
          ],
        ),
        body: Center(child: _widgetOption.elementAt(_selectedIndex)),
        drawer: Drawer(
            child: ListView(children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.deepOrange, Colors.orangeAccent])),
              child: Container(
                child: Column(children: <Widget>[
                  Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10,
                      child: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: CircleAvatar(
                            backgroundImage: ExactAssetImage(
                                'assets/images/lionel-messi-wallpaper-2017-hd.jpg'),
                            radius: 50.0,
                          )))
                ]),
              )),
          CustomListTile(Icons.person, 'Profile', () => {}),
          CustomListTile(Icons.notifications, 'Notification', () => {}),
          CustomListTile(Icons.settings, 'Setting', () => {}),
          CustomListTile(
            Icons.lock,
            'Log Out',
            _handleLogout,
          )
        ])),
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Colors.white70,
            selectedItemBorderColor: Colors.yellow,
            selectedItemBackgroundColor: Colors.green,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.black,
          ),
          selectedIndex: _selectedIndex,
          onSelectTab: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            FFNavigationBarItem(
              iconData: Icons.place,
              label: 'Places',
            ),
            FFNavigationBarItem(
              iconData: Icons.map,
              label: 'Maps',
            ),
            FFNavigationBarItem(
              iconData: Icons.home,
              label: 'Home',
            ),
            FFNavigationBarItem(
              iconData: Icons.assignment,
              label: 'News',
            ),
            FFNavigationBarItem(
              iconData: Icons.event,
              label: 'Events',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade400))),
            child: InkWell(
                splashColor: Colors.orangeAccent,
                onTap: onTap,
                child: Container(
                  height: 40,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Icon(icon),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              text,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ]),
                        Icon(Icons.arrow_right)
                      ]),
                ))));
  }
}
