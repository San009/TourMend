import 'package:flutter/material.dart';
import '../loginPage.dart';
import '../../services/forgotPass.dart';
import 'emailOTP.dart';

class ResetPage extends StatefulWidget {
  final String email;
  ResetPage({this.email});
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  GlobalKey<FormState> _formKey;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _pass, _confirmPass;
  var _showPassword = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _scaffoldKey = GlobalKey();
    _pass = TextEditingController();
    _confirmPass = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: EmailOTP(
          formKey: _formKey,
          function: _submitPass,
          heading: 'Enter new password.',
          buttonText: 'Update password',
          textSection: textSection(),
          context: context,
        ),
      ),
    );
  }

  void _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _submitPass() async {
    if (_formKey.currentState.validate()) {
      ForgotPass.onSubmit(
              email: widget.email,
              data2: _pass.text,
              label2: 'password',
              fileName: 'updatePass')
          .then((result) {
        print(result);
        if (result == '1') {
          _showSnackBar(context, 'Password updated successfully!');
          Future.delayed(Duration(milliseconds: 1000), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (route) => false);
          });
        } else if (result == '0') {
          _showSnackBar(context, "Can\'t update password! Please try again..");
        }
      });
    }
  }

  Form textSection() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _pass,
              obscureText: !_showPassword,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.black),
                labelText: 'New Password',
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                hintStyle: TextStyle(color: Colors.black),
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
            SizedBox(height: 30.0),
            TextFormField(
                controller: _confirmPass,
                cursorColor: Colors.black,
                obscureText: !_showPassword,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(Icons.lock, color: Colors.black),
                  labelText: 'Confirm Password',
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                validator: (val) {
                  if (val.length < 6) {
                    return 'Password must be atleast 6 characters long!';
                  } else if (_pass.text != _confirmPass.text) {
                    return 'Password didn\'t match';
                  }
                  return null;
                }),
          ],
        ),
      ),
    );
  }
}
