import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/modals/profileModal/userInfo.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../services/profileServices/editinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'uploadAnim.dart';
import 'dart:ui';
import 'dart:async';

class EditProfilePage extends StatefulWidget {
  final String title;
  final UserInfo userInfo;

  EditProfilePage({Key key, this.title, this.userInfo}) : super(key: key);
  static void startProgress() {}

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  bool _editStatus = true;
  final picker = ImagePicker();
  File _image;
  GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalKey<FormState> _formKey;
  String base64Image;
  String errMessage = 'Error Uploading Image';
  final FocusNode myFocusNode = FocusNode();
  TextEditingController _username;
  TextEditingController _password;
  SharedPreferences currentEmail;
  String email;
  AnimationController progressController;
  Animation<double> animation;

  Function startProgress;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    _formKey = GlobalKey<FormState>();
    _username = TextEditingController();
    _password = TextEditingController();
    email = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 250.0,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                ),
                                Text(
                                  'Back',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Stack(fit: StackFit.loose, children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 90,
                            child: ClipOval(
                              child: SizedBox(
                                width: 180.0,
                                height: 180.0,
                                child: (_image != null)
                                    ? Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        "http://10.0.2.2/TourMendWebServices/Images/profileImages/${widget.userInfo.userImage}",
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 110.0, left: 140.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                    backgroundColor: Colors.blueAccent,
                                    radius: 25.0,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.camera_alt,
                                        size: 30.0,
                                      ),
                                      onPressed: () {
                                        getImage();
                                      },
                                    ))
                              ],
                            )),
                      ]),
                    )
                  ],
                ),
              ),
              _getuploadButtons(),
              textSection(),
            ],
          ),
        ],
      ),
    ));
  }

  void _clearValues() {
    _username.text = '';
    _password.text = '';
  }

  // ignore: unused_element
  void _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _updatefield() async {
    EditInfo.edit(
      _username.text,
      _password.text,
    ).then((result) {
      print(result);
      if (result == '1') {
        _clearValues();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  'Update successfully!\n Please Login in again to see update'),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else if (result == '3') {
        _clearValues();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Incorrect  password.\nPlease try again!'),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error while updating profile!'),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  Form textSection() {
    return Form(
        key: _formKey,
        child: Container(
          color: Color(0xffFFFFFF),
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Parsonal Information',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _editStatus ? _getEditIcon() : Container(),
                          ],
                        )
                      ],
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            controller: _username,
                            decoration: const InputDecoration(
                              hintText: "Enter Your Name",
                            ),
                            validator: (value) =>
                                value.isEmpty ? 'Username is required!' : null,
                            enabled: !_editStatus,
                            autofocus: !_editStatus,
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Enter current password to update',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            controller: _password,
                            decoration:
                                const InputDecoration(hintText: "Enter "),
                            enabled: !_editStatus,
                            validator: (val) => val.length < 6
                                ? 'To Update, please enter your Tourmend password!'
                                : null,
                          ),
                        ),
                      ],
                    )),
                !_editStatus ? _getActionButtons() : Container(),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
      print('Image Path $_image');
    });
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: RaisedButton(
                child: Text("Save"),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    if (_formKey.currentState.validate()) {
                      _updatefield();
                      //_upload();
                      _editStatus = true;
                    }

                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: RaisedButton(
                child: Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _editStatus = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getuploadButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 120.0, right: 120.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: RaisedButton(
              child: Text(
                "Upload profile picture",
                style: TextStyle(fontSize: 14.5),
              ),
              textColor: Colors.white,
              color: Colors.green,
              elevation: 5.0,
              onPressed: () {
                if (_image != null) {
                  showDialog(
                      context: context,
                      child: CustomDemo(
                        _image,
                      ));
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Sorry!\nSelect Your profile image '),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.blueAccent,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _editStatus = !_editStatus;
        });
      },
    );
  }
}
