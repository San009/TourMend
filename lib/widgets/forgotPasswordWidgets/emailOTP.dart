import 'package:flutter/material.dart';

class EmailOTP extends StatelessWidget {
  final Function function;
  final String heading, buttonText;

  final GlobalKey<FormState> formKey;
  final BuildContext context;

  final Widget textSection;

  EmailOTP(
      {this.formKey,
      this.function,
      this.heading,
      this.buttonText,
      this.textSection,
      this.context});

  Container _heading() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      alignment: Alignment.center,
      child: Text(
        heading,
        style: TextStyle(
          color: Color(0xfff00BFFF),
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: double.infinity,
      height: 50.0,
      padding: EdgeInsets.only(top: 0.0),
      margin: EdgeInsets.only(top: 30.0),
      child: RaisedButton(
        onPressed: () {
          // if form is valid log in
          if (formKey.currentState.validate()) {
            function();
          }
        },
        elevation: 0.0,
        color: Colors.blue,
        child: Text(buttonText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  InkWell _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 30.0,
              ),
            ),
            Text(
              'Back',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.all(30.0),
          child: _heading(),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 10.0),
          margin: EdgeInsets.symmetric(vertical: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 200,
              ),
              textSection,
              buttonSection(),
            ],
          ),
        ),
        Positioned(
          top: 20,
          child: _backButton(),
        ),
      ],
    );
  }
}
