import 'dart:convert';
import 'package:flutter_login_signup/src/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login_signup/src/Main/Mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:email_validator/email_validator.dart';



class LoginPage extends StatefulWidget {

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  bool _isLoading = false;
  bool visible = false ;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SharedPreferences logindata;
  bool newuser;
  @override


  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }
  void check_if_already_login() async{

      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('email');
      print(email);
       runApp(MaterialApp(home: email == null ? LoginPage() : MainPage()));
    }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
   passwordController.dispose();
    super.dispose();
  }
    final formKey = GlobalKey<FormState>();
    
    String _email;
    String _password;

Container All(){

final form = formKey.currentState;

    if (form.validate()) {
     SignIn();
      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
     }else{
       return  null;
     
    }
}

 Future SignIn() async {

    setState(() {
  visible = true ; 
  });
 

  String _email = emailController.text;
  String _password = passwordController.text;
 



    var data = {'email': _email, 'password' : _password};
    var url ="http://10.0.2.2/TourMendWebServices/Login.php";
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);
    if( message=="Login Matched")
   {
        SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', '_email');
            Navigator.pushReplacement(context,
                 MaterialPageRoute(builder: (context) => MainPage()));
          }
      
   else{
    // If Email or Password did not Matched.
    // Hiding the CircularProgressIndicator.
     setState(() {
      visible = false; 
      });

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
            }
          ),
        ],
      );
    },
    );}
 
}void _loginCommand() {
  SignIn();
  }
 
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      key: scaffoldKey,
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
                  child: 
          ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            buttonSection(),
            divider(),
            gmailButton(),
            createAccountLabel(),
          ],
          ),
                   )   ],
        ),
      ),
        ],
        ),
        ),
     ),
    );
  
  }

  Container buttonSection() {
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
        child: Text("Sign In", style: TextStyle(color: Colors.white70,fontSize: 18,
                      fontWeight: FontWeight.w400)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
  
  Widget textSection() {
         return Form(
          key: formKey,
          child:Container(
          padding: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
           child: Column(
           children:<Widget>[
           new   TextFormField(
            controller: emailController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.black),
              labelText: 'Email',
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
              hintStyle: TextStyle(color: Colors.black)),
               validator: (val) => !EmailValidator.Validate(val, true)
                    ? ''
                    : null,
                onSaved: (val) => _email = val,
            ),SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.black,
            obscureText: !this._showPassword,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.black),
              labelText: 'Password',
           suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: this._showPassword ? Colors.blue : Colors.grey,
          ),
          onPressed: () {
            setState(() => this._showPassword = !this._showPassword);
          },
        ),
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
              hintStyle: TextStyle(color: Colors.white70),
          ),   validator: (val) =>
                    val.length < 4 ? '' : null,
                onSaved: (val) => _password = val,
                
            
          ),
          Visibility(
          visible: visible, 
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: CircularProgressIndicator()
            )
          )
        ],
      ),
    )
    );
  }

  Container headerSection() {
   
  
       
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      alignment: Alignment.center,
      child: Text("TourMend",
          style: TextStyle(
              color: Color(0xfff00BFFF),
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
   Widget createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
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
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
          
        
         
        ]
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