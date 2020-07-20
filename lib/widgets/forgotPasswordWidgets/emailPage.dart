import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'emailOTP.dart';
import '../../services/forgotPass.dart';
import 'otpPage.dart';

class EmailPage extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<EmailPage> {
  GlobalKey<FormState> _formKey;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _email;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _scaffoldKey = GlobalKey();
    _email = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 5.0,
                      ),
                    ),
                  ),
                  Text(
                    'Sending mail...',
                    style: TextStyle(fontSize: 15.0),
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: EmailOTP(
                formKey: _formKey,
                function: _reset,
                heading: 'Enter email address here.',
                buttonText: 'Submit Email',
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

  void _reset() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      ForgotPass.onSubmitEmail(email: _email.text).then((result) {
        setState(() {
          _isLoading = false;
        });
        print(result);
        if (result == '1') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPPage(email: _email.text),
            ),
          );
        } else if (result == '3') {
          // alert user of the error
          _showSnackBar(context, 'Please enter correct email address!');
        } else if (result == '0') {
          _showSnackBar(
              context, 'This email adderess doesn\'t have an account!');
        } else {
          _showSnackBar(context, 'Internal Server Error!');
        }
      });
    }
  }

  Form textSection() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: TextFormField(
          controller: _email,
          cursorColor: Colors.black,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            icon: Icon(
              Icons.email,
              color: Colors.black,
            ),
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
      ),
    );
  }
}
