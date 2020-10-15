import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/services/commentServices/fetchComments.dart';
import '../modals/commentModal/comments.dart';
import '../widgets/jsonListViewWidget/jsonListView.dart';
import '../widgets/commentWidgets/commentCard.dart';

class CommentPage extends StatefulWidget {
  final String newsId;
  final String userEmail;
  final Widget commentBox;

  CommentPage({
    Key key,
    @required this.newsId,
    @required this.userEmail,
    @required this.commentBox,
  }) : super(key: key);
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<CommentsData> commentsData = List();
  ScrollController _scrollController;
  GlobalKey<ScaffoldState> _scaffoldKey;
  int _pageNumber;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scaffoldKey = GlobalKey();

    _pageNumber = 1;
    _isLoading = true;

    _fetchComments().then((result) {
      if (result != null) {
        for (var place in result) {
          commentsData.add(place);
          setState(() {
            _isLoading = false;
          });
        }
      } else
        setState(() {
          _isLoading = false;
        });
    });

    _scrollController.addListener(() {
      // print(_scrollController.position.extentAfter);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _pageNumber++;
        });
        _fetchComments().then((result) {
          if (result != null) {
            for (var place in result) {
              commentsData.add(place);
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 35.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 75.0),
            child: FutureBuilder<List<CommentsData>>(
              initialData: commentsData,
              future: _fetchComments(),
              builder: (context, snapshot) {
                if (_isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (commentsData.length > 0) {
                  return JsonListView(
                    snapshot: snapshot,
                    listData: commentsData,
                    scrollController: _scrollController,
                    childWidget: (value) => CommentCard(
                      commentsData: commentsData,
                      index: value,
                    ),
                  );
                } else {
                  return Center(
                    child: Text('No comments available'),
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 5.0,
            child: widget.commentBox,
          ),
        ],
      ),
    );
  }

  Future<List<CommentsData>> _fetchComments() {
    return FetchComments.fetchComments(
            pageNumber: _pageNumber, newsId: widget.newsId)
        .then((value) => value.comments);
  }
}
