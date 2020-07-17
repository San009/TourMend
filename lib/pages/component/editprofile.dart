import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../services/editinfo.dart';
import 'package:email_validator/email_validator.dart';

class ProfilePage extends StatefulWidget {
  final String title;

  ProfilePage({Key key, this.title}) : super(key: key);
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final picker = ImagePicker();
  File _image;
  GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalKey<FormState> _formKey;
  String base64Image;
  String errMessage = 'Error Uploading Image';
  final FocusNode myFocusNode = FocusNode();
  TextEditingController _username;
  TextEditingController _email;
  TextEditingController _password;
  // TextEditingController _contact;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    _formKey = GlobalKey<FormState>();
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    //_contact = TextEditingController();
  }

  void _clearValues() {
    _username.text = '';
    _email.text = '';
    _password.text = '';
    //  _contact.text = '';
  }

  // ignore: unused_element
  void _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  updatefield() async {
    Editinfo.edit(
      _username.text,
      _email.text,
      _password.text,
    ).then((result) {
      print(result);
      if (result == '1') {
        _clearValues();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(
                  'Update successfully!\n Please Login in again to see update'),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else if (result == '0') {
        _clearValues();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Incorrect  password.\nPlease try again!'),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
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
              title: new Text('This email already has an account!'),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
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

// ignore: unused_element

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 250.0,
                color: Colors.white,
                child: new Column(
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
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 90,
                            child: ClipOval(
                              child: new SizedBox(
                                width: 180.0,
                                height: 180.0,
                                child: (_image != null)
                                    ? Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        "https://n8d.at/wp-content/plugins/aioseop-pro-2.4.11.1/images/default-user-image.png",
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 110.0, left: 140.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                    backgroundColor: Colors.red,
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

  Form textSection() {
    return Form(
        key: _formKey,
        child: Container(
          color: Color(0xffFFFFFF),
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Parsonal Information',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _status ? _getEditIcon() : new Container(),
                          ],
                        )
                      ],
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
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
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextFormField(
                            controller: _username,
                            decoration: const InputDecoration(
                              hintText: "Enter Your Name",
                            ),
                            validator: (value) =>
                                value.isEmpty ? 'Username is required!' : null,
                            enabled: !_status,
                            autofocus: !_status,
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Email ID',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextFormField(
                            controller: _email,
                            decoration: const InputDecoration(
                                hintText: "Enter Email ID"),
                            enabled: !_status,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Email is required!';
                              } else if (!EmailValidator.Validate(
                                  val, true, true)) {
                                return 'Invalid email address!';
                              } else
                                return null;
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Enter Your Password for Update',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextFormField(
                            controller: _password,
                            decoration:
                                const InputDecoration(hintText: "Enter "),
                            enabled: !_status,
                            validator: (val) => val.length < 6
                                ? 'Password must be atleast 6 characters long!'
                                : null,
                          ),
                        ),
                      ],
                    )),
                !_status ? _getActionButtons() : new Container(),
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

  Future _upload() async {
    final uri =
        Uri.parse("http://10.0.2.2/TourMendWebServices/profileimage.php");
    var request = http.MultipartRequest('POST', uri);
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image Uploaded');
    } else {
      print('Image Not Uploaded');
    }
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    if (_formKey.currentState.validate()) {
                      updatefield();
                      //_upload();
                      _status = true;
                    }

                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
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
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Upload profile pic"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  _upload();
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
