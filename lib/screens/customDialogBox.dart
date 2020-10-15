import 'package:flutter/material.dart';
import 'package:flutter_app/modals/profileModal/userInfo.dart';
import '../widgets/homePageWidgets/customListTile.dart';
import 'profilePage.dart';
import '../widgets/homePageWidgets/LogoutOverlay.dart';

class CustomDialogBox extends StatefulWidget {
  final String userEmail, userImage, userName;

  CustomDialogBox({Key key, this.userEmail, this.userImage, this.userName})
      : super(key: key);

  _CustomDialogBoxState createState() => new _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  UserInfo userInfo;
  @override
  void initState() {
    super.initState();
    userInfo = UserInfo(
      userName: widget.userName,
      userEmail: widget.userEmail,
      userImage: widget.userImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      backgroundColor: Colors.grey[300],
      titlePadding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
      contentPadding: EdgeInsets.only(top: 10),
      elevation: 20.0,
      title: Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: (widget.userImage != null)
                    ? CircleAvatar(
                        radius: 90.0,
                        backgroundImage: NetworkImage(
                          "http://10.0.2.2/TourMendWebServices/Images/profileImages/${widget.userImage}",
                        ),
                      )
                    : CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.blue,
                      )),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    widget.userName,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    widget.userEmail,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
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
                            builder: (context) =>
                                ProfilePage(userInfo: userInfo),
                          ))),
                  CustomListTile(Icons.notifications, 'Notification', () => {}),
                  CustomListTile(Icons.settings, 'Settings', () => {}),
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
}
