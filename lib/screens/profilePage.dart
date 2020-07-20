import 'package:flutter/material.dart';
import 'package:flutter_app/services/getUserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/profilePageWidgets/editProfilePage.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  ProfilePage({Key key, this.title}) : super(key: key);
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // bool _isLoading = false;
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
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          ClipPath(
            child: Container(color: Colors.black.withOpacity(0.8)),
            clipper: GetClipper(),
          ),
          Positioned(
              width: 350.0,
              top: MediaQuery.of(context).size.height / 8,
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: 170.0,
                          height: 170.0,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.all(Radius.circular(85.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ]))),

                  new Row(children: <Widget>[
                    Expanded(
                        child: SizedBox(
                      height: 195.0,
                      child: new ListView(children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.account_circle,
                            color: Colors.pink,
                            size: 35,
                          ),
                          title: Text(
                            'Name',
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(userName),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.pink,
                            size: 35,
                          ),
                          subtitle: Text(email),
                          title: Text(
                            'Email',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ]),
                    ))
                  ]),
                  //MyApp(),
                  Divider(color: Colors.black),

                  SizedBox(
                    height: 0,
                  ),
                ],
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilePage(
                  title: 'Edit Profile',
                  userName: userName,
                  email: email,
                ),
              ));
        },
        label: Text('Edit'),
        icon: Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
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

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 3);
    path.lineTo(size.width + 175, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
