import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../src/Main/Mainpage.dart';
class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}
 

class _SignUpPageState extends State<SignUpPage> {
   
  bool _isLoading = false;
 bool visible = false ;
 
 
   final scaffoldKey = GlobalKey<ScaffoldState>();
   final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 
   final formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  
    Container All(){

final form = formKey.currentState;

    if (form.validate()) {
      _submitCommand();
      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
     }else{
       return  null;
     
    }
}
  
  
  
  
    Future _submitCommand() async{
   
    setState(() {
  visible = true ; 
  });
 
  String name = nameController.text;
  String _email = emailController.text;
  String _password = passwordController.text;


   
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   var data = {'name': name, 'email': _email, 'password' :_password};
    
    var url ="http://10.0.2.2/TourMendWebServices/Register.php";
    var response = await http.post(url, body: json.encode(data));
 var message = jsonDecode(jsonEncode(response.body));
    if(message == 'Register sucessfull')
   {if(response.statusCode == 200){
  setState(() {
    visible = false; 
  });
}    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage())
      );
   }else{
 
    // If Email or Password did not Matched.
    // Hiding the CircularProgressIndicator.
      setState(() {
      visible = false;
      });
     
   }
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


 
Widget allTextField(){
          return Form(
          key: formKey,
          
          child:Container(
        padding: new EdgeInsets.only(top:20),
           child: Column(
           children:<Widget>[
           new   TextFormField(
             controller: nameController,
                decoration: InputDecoration(labelText: 'Usename',
                contentPadding: EdgeInsets.only(bottom: 10)),
               validator: (value) =>
                    value.isEmpty ? '' : null,
              ),SizedBox(height: 30,),
              new    TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email',
                contentPadding: new EdgeInsets.only(bottom: 1.0)),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => !EmailValidator.Validate(val, true)
                    ? ''
                    : null,
                onSaved: (val) => _email = val,
              ),SizedBox(height: 30,),
               new    TextFormField(
                 controller: passwordController,
                decoration: InputDecoration(labelText: 'Password',
                contentPadding: new EdgeInsets.only(bottom: 1.0)),
                validator: (val) =>
                    val.length < 4 ? '' : null,
                onSaved: (val) => _password = val,
                obscureText: true,
                
              ),SizedBox(height: 30,),
               new    TextFormField(
                 
                decoration: InputDecoration(labelText: 'Confirm Password',
                contentPadding: new EdgeInsets.only(bottom: 1.0),
                
                ),
                  validator: (val){
                              if(val.isEmpty)
                                   return '';
                              if(val != passwordController.text)
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


  Container submitButton() {
        return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.only(top: 0.0),
      margin: EdgeInsets.only(top: 30.0),
      child: RaisedButton(
           onPressed: (){
                 All();
                },
        elevation: 0.0,
        color: Colors.blue,
        child: Text("Sign Up", style: TextStyle(color: Colors.white70,fontSize: 18,
                      fontWeight: FontWeight.w400)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
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
                submitButton(),
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
