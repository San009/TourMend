import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/getUserInfo.dart';
import '../../screens/homePage.dart';
import '../../screens/placesPage.dart';
import '../../screens/eventsPage.dart';
import '../../screens/newsPage.dart';
import '../searchBar/searchBar.dart';
import '../../screens/searchPage.dart';
import '../../screens/galleryPage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences preferences;
  String userEmail, userImage, userName;
  TextEditingController _search;
  bool _canSearch, _showSearchBar;

  int _selectedIndex = 0;

  final List<Widget> _widgetOption = <Widget>[
    HomePage(
      title: 'TourMend Home Page',
    ),
    PlacesPage(
      title: 'Places',
    ),
    EventsPage(),
    NewsPage(),
    GalleryPage(),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _search = TextEditingController();
    _canSearch = false;
    _showSearchBar = true;
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Center(
              child: _widgetOption.elementAt(_selectedIndex),
            ),
            Visibility(
              visible: (_selectedIndex == 4) ? false : _showSearchBar,
              child: SearchBar(
                pageName: _getPageName(),
                canSearch: _canSearch,
                searchController: _search,
                onValueChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _canSearch = true;
                    });
                  } else {
                    setState(() {
                      _canSearch = false;
                    });
                  }
                },
                onSubmit: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      _canSearch = false;
                    });
                    return;
                  }
                  _goToSearch(value);
                },
                onTap: () {
                  _goToSearch(_search.text);
                },
                userEmail: userEmail,
                userImage: userImage,
                userName: userName,
              ),
            ),
          ],
        ),
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Colors.white70,
            selectedItemBorderColor: Colors.yellow[300],
            selectedItemBackgroundColor: Colors.blue,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.black,
          ),
          onSelectTab: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedIndex: _selectedIndex,
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
              iconData: Icons.photo_library,
              label: 'Gallery',
            ),
          ],
        ),
      ),
    );
  }

  String _getPageName() {
    switch (_selectedIndex) {
      case 0:
        return 'maps';
      case 1:
        return 'places';
      case 2:
        return 'events';
      case 3:
        return 'news';
      case 4:
        return 'images';
      default:
        return null;
    }
  }

  void _goToSearch(String value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(
          selectedIndex: _selectedIndex,
          searchString: value,
        ),
      ),
    );
  }

  void _getUserInfo() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      userEmail = preferences.getString('user_email');
    });

    GetUserInfo.getUserName(userEmail).then((value) {
      setState(() {
        userName = value;
      });
      print(userName);
    });

    GetUserInfo.getUserImage(userEmail).then((value) {
      setState(() {
        userImage = value;
      });
      print(userImage);
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
