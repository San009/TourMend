import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Code Land",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
        accentColor: Colors.white70
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }
int _selectedIndex=0;
static const TextStyle optionStyle = TextStyle(fontSize:30);
static const List<Widget> _widgetOption =<Widget>[
Text(
  'Index 0: Home',
  style: optionStyle,
),
Text(
'Index 0: Map',
  style: optionStyle,
),Text(
  'Index 0: Places',
  style: optionStyle,
),Text(
  'Index 0: News',
  style: optionStyle,
),Text(
  'Index 0: Saved',
  style: optionStyle,
),
];
  int selectedIndex = 0;
 void _onItemTapped(int index){
   setState(()
   {
     _selectedIndex = index;
   }
   );
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text("TourMend", style: TextStyle(color: Colors.white) )),
      actions: <Widget>[
          FlatButton(
            onPressed: () {
            },
            child: Icon(Icons.notifications, color: Colors.white)),
            
        ],
      ),
      body: Center(
      child:_widgetOption.elementAt(_selectedIndex)),
      drawer: Drawer(
        child: ListView(
         children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Colors.deepOrange,
                Colors.orangeAccent
              ]

              )
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                 Material(
                   borderRadius: BorderRadius.all(Radius.circular(50.0)),
                   elevation: 10,
                   child: Padding(padding:EdgeInsets.all(0.0),
                   child: CircleAvatar(
                    backgroundImage: ExactAssetImage('images/lionel-messi-wallpaper-2017-hd.jpg'),
                    radius: 50.0,
                     //child:Image.asset('images/lionel-messi-wallpaper-2017-hd.jpg',fit: BoxFit.cover,width: 80,height: 80,)))
                   )))
                ]
              ),
            )
            ),
          customListTile(Icons.person,'Profile',()=>{} ),
          customListTile(Icons.notifications,'Notification',()=>{} ),
          customListTile(Icons.settings,'Setting',()=>{} ),
          customListTile(Icons.lock,'LogOut',()=>{
            // sharedPreferences.clear();
             // sharedPreferences.commit();
             // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
          } ),

         ]
        )
      
        ),
    
       bottomNavigationBar:  FFNavigationBar(
        theme: FFNavigationBarTheme(
                 barBackgroundColor: Colors.white70,
          selectedItemBorderColor: Colors.yellow,
          selectedItemBackgroundColor: Colors.green,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
          
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.calendar_today,
            label: 'Schedule',
          ),
          FFNavigationBarItem(
            iconData: Icons.people,
            label: 'Contacts',
          ),
          FFNavigationBarItem(
            iconData: Icons.attach_money,
            label: 'Bills',
          ),
          FFNavigationBarItem(
            iconData: Icons.note,
            label: 'Notes',
          ),
          FFNavigationBarItem(
            iconData: Icons.settings,
            label: 'Settings',
          ),
        ],
      ),
    );
    
       
       
       
    
  }
}


class customListTile extends StatelessWidget {

  
 IconData icon;
 String text;
 Function onTap;

 customListTile(this.icon,this.text,this.onTap);
  @override
  Widget build(BuildContext context)
 {

return Padding(
    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
    child: Container(
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color:Colors.grey.shade400))
    ),

    child: InkWell(
      splashColor: Colors.orangeAccent,
      onTap: onTap,
child: Container(
height: 40,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
         children: <Widget>[
      Icon(icon),
      Padding(
        padding: const EdgeInsets.all(8.0),
       child: Text(text,style: TextStyle(fontSize:16.0),),
      ),
         ]),
         Icon(Icons.arrow_right)
    ]
  ),
)
    )));
 }

 
}
