import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/widgets/jsonListViewWidget/jsonListView.dart';
import 'package:flutter_app/widgets/newsWidgets/newsCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/fetchNews.dart';
import '../modals/newsModal/news.dart';
import '../widgets/newsWidgets/detailNews.dart';

class NewsPage extends StatefulWidget {
  final String title;

  NewsPage({Key key, this.title}) : super(key: key);
  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<NewsPage> {
  SharedPreferences email;
  String _userEmail;
  List<NewsData> _newsData;
  ScrollController _scrollController;
  int _pageNumber;
  bool _isLoading, _showSearchBar;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _pageNumber = 1;
    _isLoading = true;
    _showSearchBar = true;
    _newsData = List();

    _fetchNews().then((result) {
      for (var newS in result) {
        _newsData.add(newS);
        setState(() {
          _isLoading = false;
        });
      }
    });

    _scrollController.addListener(() {
      // print(_scrollController.position.extentAfter);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _pageNumber++;
        });
        _fetchNews().then((result) {
          if (result != null) {
            for (var newS in result) {
              _newsData.add(newS);
            }
          }
        });
      }
    });

    _handleScroll();
    _getUserEmail();
  }

  void _getUserEmail() async {
    email = await SharedPreferences.getInstance();
    _userEmail = email.getString('user_email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _fetchNews().then((value) {
          // do something
        }),
        child: Container(
          padding: _showSearchBar
              ? EdgeInsets.only(top: 55.0)
              : EdgeInsets.only(top: 0.0),
          child: FutureBuilder<List<NewsData>>(
            initialData: _newsData,
            future: _fetchNews(),
            builder: (context, snapshot) {
              if (_isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return JsonListView(
                snapshot: snapshot,
                listData: _newsData,
                scrollController: _scrollController,
                onTapWidget: (value) => DetailNews(
                  userEmail: _userEmail,
                  newsData: _newsData[value],
                ),
                childWidget: (value) => NewsCard(
                  newsData: _newsData,
                  index: value,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<List<NewsData>> _fetchNews() {
    return FetchNews.fetchNews(pageNumber: _pageNumber)
        .then((value) => value.news);
  }

  void _handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          _scrollController.position.pixels >= 36) {
        setState(() {
          _showSearchBar = false;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _showSearchBar = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
