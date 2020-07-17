import 'package:flutter/material.dart';
import '../../services/forgotPass.dart';
import 'resetPage.dart';

import 'emailOTP.dart';

class OTPPage extends StatefulWidget {
  final String email;
  OTPPage({this.email});
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<OTPPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalKey<FormState> _formKey;
  TextEditingController _otpCode;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _scaffoldKey = GlobalKey();
    _otpCode = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _isLoading
          ? Center(
              child: SizedBox(
                height: 200.0,
                width: 200.0,
                child: CircularProgressIndicator(
                  strokeWidth: 5.0,
                ),
              ),
            )
          : SingleChildScrollView(
              child: EmailOTP(
                formKey: _formKey,
                function: _submitOTP,
                heading: 'Enter OTP code here.',
                buttonText: 'Submit OTP',
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

  void _submitOTP() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      ForgotPass.onSubmit(
              email: widget.email,
              label2: 'otp',
              fileName: 'checkOTP',
              data2: _otpCode.text)
          .then((result) {
        setState(() {
          _isLoading = false;
        });
        print(result);
        if (result == '1') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPage(email: widget.email),
            ),
          );
        } else if (result == '0') {
          _showSnackBar(context, 'OTP didn\'t match');
        } else {
          _showSnackBar(context, 'Internal Server error!');
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
          controller: _otpCode,
          keyboardType: TextInputType.number,
          cursorColor: Colors.black,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            icon: Icon(
              Icons.vpn_key,
              color: Colors.black,
            ),
            labelText: 'OTP Code',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            hintStyle: TextStyle(color: Colors.black),
          ),
          validator: (val) {
            if (val.isEmpty) {
              return 'OTP is required!';
            } else if (val.length != 6) {
              return 'Invalid length for OTP code!';
            } else
              return null;
          },
        ),
      ),
    );
  }
}
