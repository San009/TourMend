import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/loginPage.dart';

class LogoutOverlay extends StatefulWidget {
  LogoutOverlay({Key key}) : super(key: key);
  State<StatefulWidget> createState() => LogoutOverlayState();
}

class LogoutOverlayState extends State<LogoutOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  SharedPreferences preferences;
  String userEmail;

  @override
  void initState() {
    super.initState();
    _getUserEmail();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: EdgeInsets.all(37.0),
              padding: EdgeInsets.all(15.0),
              height: 180.0,
              decoration: ShapeDecoration(
                  color: Color.fromRGBO(50, 200, 100, 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 20.0, right: 20.0),
                    child: Text(
                      "Are you sure, you want to logout?",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  )),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonTheme(
                            height: 35.0,
                            minWidth: 110.0,
                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              splashColor: Colors.white.withAlpha(40),
                              child: Text(
                                'Logout',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red[400],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0),
                              ),
                              onPressed: () async {
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
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                          child: ButtonTheme(
                              height: 35.0,
                              minWidth: 110.0,
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                splashColor: Colors.white.withAlpha(40),
                                child: Text(
                                  'Cancel',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context).pop(false);
                                    /* Route route = MaterialPageRoute(
                                          builder: (context) => LoginScreen());
                                      Navigator.pushReplacement(context, route);
                                   */
                                  });
                                },
                              ))),
                    ],
                  ))
                ],
              )),
        ),
      ),
    );
  }

  _getUserEmail() async {
    preferences = await SharedPreferences.getInstance();
    userEmail = preferences.getString('user_email');
  }
}
