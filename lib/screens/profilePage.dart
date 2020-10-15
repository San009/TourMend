import 'package:flutter/material.dart';
import 'package:flutter_app/modals/profileModal/userInfo.dart';
import '../widgets/profilePageWidgets/editProfilePage.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  final UserInfo userInfo;
  ProfilePage({Key key, this.title, this.userInfo}) : super(key: key);
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          ClipPath(
            child: Container(color: Colors.black.withOpacity(0.7)),
            clipper: GetClipper(),
          ),
          Positioned(
              width: 350.0,
              top: MediaQuery.of(context).size.height / 8,
              left: 30.0,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 170.0,
                    height: 170.0,
                    margin: EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: NetworkImage(
                            "http://10.0.2.2/TourMendWebServices/Images/profileImages/${widget.userInfo.userImage}",
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(85.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10.0,
                            offset: Offset(10.0, 20.0),
                            color: Colors.grey[400],
                            spreadRadius: 2.0)
                      ],
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                        child: SizedBox(
                      height: 160.0,
                      child: ListView(children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 5.0),
                          visualDensity: VisualDensity(
                            horizontal: VisualDensity.maximumDensity,
                          ),
                          leading: Icon(
                            Icons.account_circle,
                            color: Colors.green,
                            size: 35,
                          ),
                          title: Text(
                            'Name',
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(widget.userInfo.userName),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 5.0),
                          visualDensity: VisualDensity(
                              horizontal: VisualDensity.maximumDensity),
                          leading: Icon(
                            Icons.email,
                            color: Colors.green,
                            size: 35,
                          ),
                          subtitle: Text(widget.userInfo.userEmail),
                          title: Text(
                            'Email',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ]),
                    ))
                  ]),
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
                  userInfo: widget.userInfo,
                ),
              ));
        },
        label: Text(
          'Edit',
          style: TextStyle(fontSize: 18.0),
        ),
        icon: Icon(
          Icons.edit,
          size: 20.0,
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
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
    return true;
  }
}
