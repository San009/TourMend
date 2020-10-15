import 'package:flutter/material.dart';
import 'package:flutter_app/modals/galleryModal/gallery.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GalleryCard extends StatefulWidget {
  @override
  _GalleryCardState createState() => _GalleryCardState();
  final List<GalleryData> galleryData;
  final int index;
  final String userImage;

  GalleryCard({
    this.galleryData,
    this.index,
    this.userImage,
  });
}

class _GalleryCardState extends State<GalleryCard> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: Card(
            elevation: 0.0,
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 18.0, top: 15.0),
                            child: (widget.userImage == null)
                                ? CircleAvatar(
                                    child: Icon(Icons.person),
                                    backgroundColor: Colors.blueAccent,
                                    radius: 20.0,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'http://10.0.2.2/TourMendWebServices/Images/profileImages/${widget.galleryData[widget.index].userImage}'),
                                    radius: 20.0,
                                  )),
                        new SizedBox(
                          width: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0, top: 15.0),
                          child: Text(
                            widget.galleryData[widget.index].userName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.black),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    new IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: null,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Image.network(
                    'http://10.0.2.2/TourMendWebServices/Images/Gallery/${widget.galleryData[widget.index].image}',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new IconButton(
                            icon: new Icon(isPressed
                                ? Icons.favorite
                                : FontAwesomeIcons.heart),
                            color: isPressed ? Colors.red : Colors.black,
                            onPressed: () {
                              setState(() {
                                isPressed = !isPressed;
                              });
                            },
                          ),
                          new SizedBox(
                            width: 16.0,
                          ),
                          new Icon(
                            FontAwesomeIcons.comment,
                          ),
                          new SizedBox(
                            width: 16.0,
                          ),
                          new Icon(FontAwesomeIcons.paperPlane),
                        ],
                      ),
                      new Icon(FontAwesomeIcons.bookmark)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    "Liked by pawankumar, pk and 528,331 others",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                  'http://10.0.2.2/TourMendWebServices/Images/profileImages/${widget.userImage}')),
                        ),
                      ),
                      new SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: new TextField(
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add a comment...",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                  child: Row(children: <Widget>[
                    Flexible(
                      child: Text(
                        widget.galleryData[widget.index].description,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            color: Colors.black87),
                      ),
                    ),
                  ]),
                ),
              ],
            )));
  }
}
