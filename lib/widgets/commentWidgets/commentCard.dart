import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/modals/commentModal/comments.dart';

class CommentCard extends StatefulWidget {
  final List<CommentsData> commentsData;
  final int index;

  CommentCard({
    this.commentsData,
    this.index,
  });

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _likePressed;

  @override
  void initState() {
    super.initState();
    _likePressed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
      elevation: 3.0,
      borderOnForeground: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(
              left: 18.0,
              top: 5.0,
              right: 5.0,
            ),
            leading: InkWell(
              child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                      'http://10.0.2.2/TourMendWebServices/Images/profileImages/${widget.commentsData[widget.index].userImage}')),
            ),
            title: Text(
              '${widget.commentsData[widget.index].userName}',
              style: TextStyle(
                  letterSpacing: 0.75,
                  fontSize: 13.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                '${widget.commentsData[widget.index].comment}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
            trailing: IconButton(
              splashRadius: 22.0,
              onPressed: () {
                setState(() {
                  _likePressed = !_likePressed;
                });
                // do other stuffs
              },
              icon: Icon(
                Icons.thumb_up,
                color: (_likePressed) ? Colors.blueAccent : Colors.grey,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 5.0,
            ),
            height: 32.0,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Color(0xff3b5998),
                      child: Icon(
                        Icons.thumb_up,
                        size: 10.0,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                      child: Text('likes'),
                    ),
                  ],
                ),
                _showPopupMenu(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _showPopupMenu() {
    return PopupMenuButton(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      icon: Icon(Icons.more_horiz),
      itemBuilder: (context) {
        return menuItems.map((MenuItem menuItem) {
          return PopupMenuItem(
              child: ListTile(
            // material button or custom list tile
            contentPadding: EdgeInsets.all(0.0),
            dense: true,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              child: Icon(
                menuItem.icon,
                size: 20.0,
                color: (menuItem.menu == 'Delete')
                    ? Colors.redAccent
                    : Colors.blue,
              ),
            ),
            title: Text(
              menuItem.menu,
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ));
        }).toList();
      },
    );
  }
}

class MenuItem {
  String menu;
  IconData icon;

  MenuItem(this.menu, this.icon);
}

final List<MenuItem> menuItems = [
  MenuItem('Edit', Icons.edit),
  MenuItem('Delete', Icons.delete),
];
