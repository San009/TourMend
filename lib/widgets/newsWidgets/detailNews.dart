import 'package:flutter/material.dart';

import '../../modals/newsModal/news.dart';

class DetailNews extends StatefulWidget {
  final NewsData newsData;
  DetailNews({Key key, this.newsData}) : super(key: key);
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  void showDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 188,
            child: SizedBox.expand(
                child: Column(
              children: <Widget>[
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 20.0, top: 10.0, bottom: 10.0),
                          child: ClipOval(
                            child: Material(
                              // button color
                              child: InkWell(
                                child: SizedBox(
                                    width: 56,
                                    height: 56, // inkwell color
                                    child: Image.asset(
                                        'assets/Images/facebook.png')),
                                onTap: () {},
                              ),
                            ),
                          )),
                      Container(
                          child: Text(
                        "Facebook",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ))
                      // inkwell color
                    ]),
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                          child: ClipOval(
                            child: Material(
                              // button color
                              child: InkWell(
                                child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: Image.asset(
                                        'assets/Images/twitter.png')),
                                onTap: () {},
                              ),
                            ),
                          )),
                      Container(
                          child: Text(
                        "Twitter",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ))
                    ])
                  ],
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 40.0, right: 10.0, top: 10.0, bottom: 10.0),
                        child: ButtonTheme(
                            height: 35.0,
                            minWidth: 310.0,
                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              splashColor: Colors.black.withAlpha(40),
                              child: Text(
                                'Cancel',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0),
                              ),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).pop(false);
                                  /* Route route = MaterialPageRoute(
                                          builder: (context) => LoginScreen());
                                      Navigator.pushReplacement(context, route);
                                   */
                                });
                              },
                            ))),
                  ],
                ))
              ],
            )),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Center(
            child: Text(
          'News ',
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.white,
          ),
        )),
        actions: <Widget>[
          FlatButton(
            child: Row(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[
                Text(
                  "150",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.mode_comment,
                  size: 18,
                  color: Colors.white,
                )
              ],
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Text(
                      widget.newsData.headLine,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Padding(
                    child: Stack(children: <Widget>[
                      Image.network(
                        'http://10.0.2.2/TourMendWebServices/Images/news/${widget.newsData.image}',
                        fit: BoxFit.cover,
                        height: 250,
                      ),
                    ]),
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Text(
                      widget.newsData.des,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18.0,
                        height: 1.5,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            new Row(
              children: <Widget>[
                Container(
                  width: 410,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: new Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(7),
                        width: 320,
                        child: TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            contentPadding: EdgeInsets.all(10.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            hintText: 'Add a Comment',
                            prefixIcon: Icon(Icons.edit, color: Colors.grey),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      InkWell(
                          onTap: () => print("2"),
                          child: Padding(
                              padding: EdgeInsets.all(7.0),
                              child: const Icon(Icons.mode_comment,
                                  color: Colors.grey))),
                      InkWell(
                          onTap: () => showDialog(),
                          child: Padding(
                              padding: EdgeInsets.all(7.0),
                              child:
                                  const Icon(Icons.share, color: Colors.grey))),
                    ],
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
