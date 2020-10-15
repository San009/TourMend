import 'dart:ui';
import "package:flutter/material.dart";

class CommentInputWidget extends StatefulWidget {
  final ValueChanged<String> onValueChanged, onSubmit;
  final VoidCallback onTap, onLikePressed;

  final TextEditingController commentController;
  final bool canComment;
  final String newsId;
  final bool isLiked;
  final bool showLike;

  CommentInputWidget({
    @required this.onValueChanged,
    @required this.onSubmit,
    @required this.onTap,
    @required this.onLikePressed,
    @required this.commentController,
    @required this.canComment,
    @required this.isLiked,
    @required this.showLike,
    this.newsId,
  });

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentInputWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(),
          Container(
            height: 50.0,
            margin: EdgeInsets.only(left: 10.0),
            width: MediaQuery.of(context).size.width - 70,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(width: 1.0),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(0.0, -2.5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: (widget.showLike)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 5.0, bottom: 9.0, right: 5.0),
                  width: MediaQuery.of(context).size.width * 3 / 4 - 50,
                  child: TextField(
                    autofocus: false,
                    textAlignVertical: TextAlignVertical.bottom,
                    textInputAction: TextInputAction.send,
                    controller: widget.commentController,
                    onChanged: (value) {
                      widget.onValueChanged(value);
                    },
                    onSubmitted: (value) {
                      widget.onSubmit(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 10.0,
                        bottom: 13.0,
                      ),
                      border: InputBorder.none,
                      hintText: 'Add a Comment',
                      hintStyle: TextStyle(
                        fontSize: 17.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: widget.canComment ? () => widget.onTap() : () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 10.0,
                        ),
                        child: Icon(
                          Icons.send,
                          size: 20.0,
                          color: widget.canComment ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                    (widget.showLike)
                        ? InkWell(
                            onTap: () => widget.onLikePressed(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 10.0,
                              ),
                              child: Icon(
                                Icons.thumb_up,
                                size: 20.0,
                                color: (widget.isLiked)
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          )
                        : Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
