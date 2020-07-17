import 'package:flutter/material.dart';
import 'component/editprofile.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Profile extends StatefulWidget {
  var userEmail;
  Profile({Key key, this.userEmail}) : super(key: key);
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  List data;

  var _isLoading = false;
  String username = "username ", email = "email ";

  Future<String> getLogin(String id) async {
    var response = await http.get(Uri.encodeFull(
        "http://10.0.2.2/TourMendWebServices/userinfo.php?email=" +
            id.toString()));

    setState(() {
      _isLoading = true;
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['result'];
      if (data != null) {
        username = data[0]['username'];
        email = data[0]['email'];
      }
    });
    print(data);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getLogin(widget.userEmail);
    });
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
                          subtitle: Text(username),
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
                builder: (context) => ProfilePage(),
              ));
        },
        label: Text('Edit'),
        icon: Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
    );
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
    // TODO: implement shouldReclip
    return true;
  }
}
