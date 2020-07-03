import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/mainPageWidgets/customListTile.dart';

class CustomDialogBox extends StatelessWidget {
  CustomDialogBox({this.userEmail, this.logoutFunciton});

  final String userEmail;
  final Function logoutFunciton;

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
                backgroundColor: Colors.deepPurple,
                child: Icon(
                  Icons.portrait,
                  size: 50.0,
                ),
              ),
            ),
            Center(
              child: Text('$userEmail'),
            )
          ],
        ),
      ),
      children: <Widget>[
        Container(
            width: 380.0,
            height: 330.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  CustomListTile(Icons.person, 'Profile', () => {}),
                  CustomListTile(Icons.notifications, 'Notification', () => {}),
                  CustomListTile(Icons.settings, 'Setting', () => {}),
                  CustomListTile(
                    Icons.lock,
                    'Log Out',
                    logoutFunciton,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
