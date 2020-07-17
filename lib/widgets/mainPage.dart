import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter_app/widgets/mainPageWidgets/homePageWidgets/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainPageWidgets/homePageWidgets/homePage.dart';
import 'mainPageWidgets/placesWidgets/placesPage.dart';

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
  static const TextStyle optionStyle = TextStyle(fontSize: 30);
  static List<Widget> _widgetOption = <Widget>[
    HomePage(
      title: 'Tourmend Home Page',
    ),
    PlacesPage(
      title: 'Places',
    ),
    Text(
      'Index 3: Events',
      style: optionStyle,
    ),
    Text(
      'Index 4: News',
      style: optionStyle,
    ),
    Text(
      'Index 5: Saved',
      style: optionStyle,
    ),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        body: Center(child: _widgetOption.elementAt(_selectedIndex)),
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
              iconData: Icons.home,
              label: 'Home',
            ),
            FFNavigationBarItem(
              iconData: Icons.place,
              label: 'Places',
            ),
            FFNavigationBarItem(
              iconData: Icons.event,
              label: 'Events',
            ),
            FFNavigationBarItem(
              iconData: Icons.assignment,
              label: 'News',
            ),
            FFNavigationBarItem(
              iconData: Icons.save,
              label: 'Saved',
            ),
          ],
        ),
      ),
    );
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
            actionsPadding: EdgeInsets.all(5.0),
            buttonPadding: EdgeInsets.all(20.0),
            title: Text('Are you sure?'),
            content: Text('Do you want to exit TourMend'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  "NO",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text(
                  "YES",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
