import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../widgets/mainPageWidgets/mainPage.dart';
import '../screens/loginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _logoAnimationController;
  Animation<double> _logoAnimation;
  SharedPreferences _loginData;
  @override
  void initState() {
    super.initState();
    _logoAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    _logoAnimation = new CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeOut,
    );

    _logoAnimation.addListener(() => this.setState(() {}));
    _logoAnimationController.forward();
    Timer(Duration(seconds: 5), () => _checkIfAlreadyLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.greenAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlutterLogo(
                        size: _logoAnimation.value * 100,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      ),
                      Text(
                        TourMend.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      TourMend.subName,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _checkIfAlreadyLogin() async {
    _loginData = await SharedPreferences.getInstance();
    final newuser = (_loginData.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            title: 'Tourmend Main Page',
          ),
        ),
      );
    } else if (newuser == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }
}

class TourMend {
  static const String name = "TourMend";
  static const String subName =
      '"Live with no excuses, \nTravel with no regrets"';
}
