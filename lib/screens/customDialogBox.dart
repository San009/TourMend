import 'package:flutter/material.dart';
import '../widgets/homePageWidgets/customListTile.dart';
import 'profilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/profileServices/getUserInfo.dart';
import '../widgets/homePageWidgets/LogoutOverlay.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class CustomDialogBox extends StatefulWidget {
  final String userEmail;
  final Function logoutFunciton;
  CustomDialogBox({Key key, this.userEmail, this.logoutFunciton})
      : super(key: key);
  @override
  _CustomDialogBoxState createState() => new _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  String userEmail;
  Function logoutFunciton;
  String userName, email;
  SharedPreferences currentEmail;

  @override
  void initState() {
    super.initState();
    userName = '';
    email = '';
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      backgroundColor: Colors.grey[300],
      titlePadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
      contentPadding: EdgeInsets.only(top: 10),
      elevation: 20.0,
      title: Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.blue,
                  backgroundImage: AdvancedNetworkImage(
                      "http://10.0.2.2/TourMendWebServices/Images/profileImages/" +
                          userName +
                          ".png",
                      fallbackAssetImage: 'asset/Images/tm.jpg'),
                )),
            Center(
              child: Text(userName),
            )
          ],
        ),
      ),
      children: <Widget>[
        Container(
            width: 380.0,
            height: 315.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  CustomListTile(
                      Icons.person,
                      'Profile',
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ))),
                  CustomListTile(Icons.notifications, 'Notification', () => {}),
                  CustomListTile(Icons.settings, 'Setting', () => {}),
                  CustomListTile(
                      Icons.lock,
                      'Log Out',
                      () => {
                            showDialog(
                              context: context,
                              builder: (_) => LogoutOverlay(),
                            )
                          }),
                ],
              ),
            )),
      ],
    );
  }

  void _getUserInfo() async {
    currentEmail = await SharedPreferences.getInstance();
    setState(() {
      email = currentEmail.getString('user_email');
    });

    GetUserInfo.getUserInfo(email).then((result) {
      if (result != null) {
        setState(() {
          userName = result;
        });
      }
    });
  }
}
