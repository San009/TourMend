import 'package:flutter/material.dart';

import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}
 

class _SignUpPageState extends State<SignUpPage> {
   
 
   final scaffoldKey = GlobalKey<ScaffoldState>();
    final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
   final formKey = GlobalKey<FormState>();
   String _email;
  String _password;

  
  void _submitCommand() {
    //get state of our Form
    final form = formKey.currentState;

    //`validate()` validates every FormField that is a descendant of this Form,
    // and returns true if there are no errors.
    if (form.validate()) {
      //`save()` Saves every FormField that is a descendant of this Form.
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _loginCommand();
    }
  }
  void _loginCommand() {
    // Show login details in snackbar
    final snackbar = SnackBar(
      content: Text('Email: $_email, password: $_password'),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
Widget allTextField(){
          return Form(
          key: formKey,
          child:Container(
        padding: new EdgeInsets.only(top:20),
           child: Column(
           children:<Widget>[
           new   TextFormField(
             
                decoration: InputDecoration(labelText: 'Usename',
                contentPadding: EdgeInsets.only(bottom: 10)),
               validator: (value) =>
                    value.isEmpty ? '' : null,
              ),SizedBox(height: 30,),
              new    TextFormField(
                decoration: InputDecoration(labelText: 'Email',
                contentPadding: new EdgeInsets.only(bottom: 1.0)),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => !EmailValidator.Validate(val, true)
                    ? ''
                    : null,
                onSaved: (val) => _email = val,
              ),SizedBox(height: 30,),
               new    TextFormField(
                 controller: _pass,
                decoration: InputDecoration(labelText: 'Password',
                contentPadding: new EdgeInsets.only(bottom: 1.0)),
                validator: (val) =>
                    val.length < 4 ? '' : null,
                onSaved: (val) => _password = val,
                obscureText: true,
                
              ),SizedBox(height: 30,),
               new    TextFormField(
                 controller: _confirmPass,
                decoration: InputDecoration(labelText: 'Confirm Password',
                contentPadding: new EdgeInsets.only(bottom: 1.0),
                
                ),
                  validator: (val){
                              if(val.isEmpty)
                                   return '';
                              if(val != _pass.text)
                                   return 'Not Match';
                              return null;
                              },


               obscureText: true,
              ),
               
        ],
      ),
    ),
          );
   }


  Widget _submitButton() {
    return InkWell(
      onTap: _submitCommand,
      child: 
     Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          color: Color(0xff00BFFF)
          ),
      child: Text(
        'Register Now',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ));
  }

Widget _backButton() {
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
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Color(0xff00BFFF),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      
      text: TextSpan(
        
          text: 'T',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            
            fontWeight: FontWeight.w700,
            
            color: Color(0xff00BFFF),
          ),
          children: [
            TextSpan(
              text: 'our',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Mend',
              style: TextStyle(color: Color(0xff00BFFF), fontSize: 30),
            ),
          ]),
    );
  }

  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
          .of(context)
          .size
          .height,
    child: new Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    
                  ),
                ),
                _title(),
                SizedBox(
                  height: 80,
                ),
                allTextField(),
                SizedBox(
                  height: 100,
                  width: 10,
                ),
                _submitButton(),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height:100,
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _loginAccountLabel(),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
         
        ],
      ),
    )
      ),
    );
    
    
  }
}
