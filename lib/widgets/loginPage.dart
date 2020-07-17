import 'forgotPasswordWidgets/emailPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/loginSignup.dart';
import 'signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mainPage.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;

  TextEditingController _email;
  TextEditingController _password;
  GlobalKey<FormState> _formKey;

  SharedPreferences _loginData;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _formKey = GlobalKey();

    _checkIfAlreadyLogin();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: new Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: ListView(
                          children: <Widget>[
                            headerSection(),
                            textSection(),
                            forgotPasswordLabel(),
                            buttonSection(),
                            divider(),
                            gmailButton(),
                            createAccountLabel(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actionsPadding: EdgeInsets.all(5.0),
            buttonPadding: EdgeInsets.all(20.0),
            title: Text('Are you sure?'),
            content: Text('Do you want to exit TourMend'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  "NO",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text(
                  "YES",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ) ??
        false;
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
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
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

  void _logIn() async {
    if (_formKey.currentState.validate()) {
      LoginSignup.login(_email.text, _password.text).then((result) {
        print(result);
        if (result == '1') {
          _loginData.setBool('login', false);
          _loginData.setString('user_email', _email.text);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(
                  title: 'Tourmend Main Page',
                ),
              ),
              (route) => false);
        } else if (result == '0') {
          setState(() {
            _email.text = '';
            _password.text = '';
          });
          _showDialog('Incorrect username or password!');
        } else if (result == '3') {
          // show dialog box
          _showDialog(
              'Your account is not activated!\nCheck your email to activate your account.');
        } else {
          // show dialog box
          _showDialog('Internal Server Error!');
        }
      });
    }
  }

  Column buttonSection() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          padding: EdgeInsets.only(top: 0.0),
          margin: EdgeInsets.only(top: 30.0),
          child: RaisedButton(
            onPressed: () {
              // if form is valid log in
              if (_formKey.currentState.validate()) {
                _logIn();
              }
            },
            elevation: 0.0,
            color: Colors.blue,
            child: Text("Sign In",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Form textSection() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _email,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                icon: Icon(Icons.email, color: Colors.black),
                labelText: 'Email',
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                hintStyle: TextStyle(color: Colors.black),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return 'Email is required!';
                } else if (!EmailValidator.Validate(val, true, true)) {
                  return 'Invalid email address!';
                } else
                  return null;
              },
            ),
            SizedBox(height: 30.0),
            TextFormField(
              controller: _password,
              cursorColor: Colors.black,
              obscureText: !_showPassword,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                icon: Icon(Icons.lock, color: Colors.black),
                labelText: 'Password',
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                hintStyle: TextStyle(color: Colors.white70),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: this._showPassword ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () =>
                      setState(() => _showPassword = !_showPassword),
                ),
              ),
              validator: (val) => val.length < 6
                  ? 'Password must be atleast 6 characters long!'
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Container headerSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      alignment: Alignment.center,
      child: Text(
        "TourMend",
        style: TextStyle(
          color: Color(0xfff00BFFF),
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget createAccountLabel() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account?',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff00BFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget forgotPasswordLabel() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Forgot Password?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EmailPage()));
            },
            child: Text(
              'Click here!',
              style: TextStyle(
                  color: Colors.red[800],
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget gmailButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffB23121),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('G',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffD44638),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Gmail',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }
}
