import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/commentPage.dart';
import 'package:flutter_app/services/commentServices/addComment.dart';
import '../../modals/newsModal/news.dart';
import '../commentWidgets/commentInputWidget.dart';

class DetailNews extends StatefulWidget {
  final NewsData newsData;
  final String userEmail;
  DetailNews({
    Key key,
    @required this.newsData,
    @required this.userEmail,
  }) : super(key: key);
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> with TickerProviderStateMixin {
  TextEditingController _commentController;
  bool _canComment, _isLiked;
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    _commentController = TextEditingController();
    _canComment = _isLiked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'News',
          style: TextStyle(
            letterSpacing: 8.0,
            shadows: [
              Shadow(color: Colors.grey[300], offset: Offset(10.0, 5.0))
            ],
            fontSize: 30.0,
            fontFamily: 'BioRhyme',
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            alignment: Alignment.center,
            splashRadius: 20.0,
            icon: Icon(
              Icons.share,
              size: 20.0,
            ),
            onPressed: () => _showDialog(),
          ),
          IconButton(
              icon: Icon(
                Icons.comment,
                size: 20.0,
              ),
              splashRadius: 20.0,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CommentPage(
                        commentBox: _commentBox(showLikeButton: false),
                        newsId: widget.newsData.id,
                        userEmail: widget.userEmail,
                      ))))
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 85.0),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                    child: Image.network(
                      'http://10.0.2.2/TourMendWebServices/Images/news/${widget.newsData.image}',
                      fit: BoxFit.cover,
                      height: 250.0,
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                    child: Text(
                      widget.newsData.des,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 20.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        vertical: BorderSide(
                          color: Colors.grey[500],
                          width: 1.0,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isLiked = !_isLiked;
                                });
                              },
                              icon: Icon(Icons.thumb_up),
                              color: (_isLiked) ? Colors.blue : Colors.grey,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                '150',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CommentPage(
                                        commentBox:
                                            _commentBox(showLikeButton: false),
                                        newsId: widget.newsData.id,
                                        userEmail: widget.userEmail,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.comment),
                                color: Colors.black87),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text('150'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            child: _commentBox(showLikeButton: true),
          ),
        ],
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

  void _addComment({String comment}) async {
    AddComments.addComment(comment, widget.userEmail, widget.newsData.id)
        .then((result) {
      print(result);
      if (result == '1') {
        _showSnackBar(context, 'Comment added!');
        _commentController.text = '';
      } else if (result == '0') {
        _showSnackBar(context, 'Error while adding comment!');
      } else if (result == '2') {
        _showSnackBar(context, 'Email while fetching user id!');
      } else if (result == '3') {
        _showSnackBar(context, 'Error in method!');
      }
    });
  }

  Widget _commentBox({bool showLikeButton}) {
    return CommentInputWidget(
      showLike: showLikeButton,
      isLiked: _isLiked,
      newsId: widget.newsData.id,
      commentController: _commentController,
      canComment: _canComment,
      onLikePressed: () {
        setState(() {
          _isLiked = !_isLiked;
        });
      },
      onValueChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            _canComment = true;
          });
        } else {
          setState(() {
            _canComment = false;
          });
        }
      },
      onSubmit: (value) {
        if (value.isEmpty) {
          setState(() {
            _canComment = false;
          });
          return;
        }
        _addComment(comment: value);
      },
      onTap: () => _addComment(comment: _commentController.text),
    );
  }

  void _showDialog() {
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
                                        'assets/social_media/facebook.png')),
                                onTap: () {},
                              ),
                            ),
                          )),
                      Container(
                          child: Text(
                        "Facebook",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          decoration: TextDecoration.none,
                        ),
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
                                        'assets/social_media/twitter.png')),
                                onTap: () {},
                              ),
                            ),
                          )),
                      Container(
                          child: Text(
                        "Twitter",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            decoration: TextDecoration.none,
                            fontStyle: FontStyle.normal),
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
                            minWidth: MediaQuery.of(context).size.width - 100,
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
}
