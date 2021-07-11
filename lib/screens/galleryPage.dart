import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modals/galleryModal/gallery.dart';
import '../services/fetchGallery.dart';
import '../services/getUserInfo.dart';
import '../widgets/galleryWidget/galleryCard.dart';
import '../widgets/jsonListViewWidget/jsonListView.dart';

class GalleryPage extends StatefulWidget {
  final String title;
  final String userImage;

  GalleryPage({Key key, this.title, this.userImage}) : super(key: key);
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  SharedPreferences preferences;
  // ignore: deprecated_member_use
  List<GalleryData> galleryData = List();
  ScrollController _scrollController;
  int _pageNumber;
  bool _isLoading;
  String userImage;

  // bool _showSearchBar;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // _showSearchBar = true;
    _pageNumber = 1;
    _isLoading = true;

    _fetchGallery().then((result) {
      print(result);
      if (result != null) {
        setState(() {
          _isLoading = false;
        });
        for (var gallery in result) {
          galleryData.add(gallery);
        }
      }
    });

    _scrollController.addListener(() {
      // print(_scrollController.position.extentAfter);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _pageNumber++;
        });
        _fetchGallery().then((result) {
          if (result != null) {
            for (var gallery in result) {
              galleryData.add(gallery);
            }
          }
        });
      }
    });

    _handleScroll();
    _getUserImage();
  }

  void _getUserImage() async {
    preferences = await SharedPreferences.getInstance();
    var userEmail = preferences.getString('user_email');

    GetUserInfo.getUserImage(userEmail).then((value) {
      setState(() {
        userImage = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        elevation: 1.0,
        leading: new Icon(
          Icons.camera_alt,
          color: Colors.black,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(Icons.send),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _fetchGallery().then((value) {
          // do something
        }),
        child: Container(
          child: FutureBuilder<List<GalleryData>>(
            initialData: galleryData,
            future: _fetchGallery(),
            builder: (context, snapshot) {
              if (_isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return JsonListView(
                snapshot: snapshot,
                listData: galleryData,
                scrollController: _scrollController,
                childWidget: (value) => GalleryCard(
                  galleryData: galleryData,
                  index: value,
                  userImage: userImage,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<List<GalleryData>> _fetchGallery() {
    return FetchGallery.fetchGallery(pageNumber: _pageNumber)
        .then((value) => value.gallery);
  }

  void _handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          _scrollController.position.pixels >= 36) {
        // setState(() {
        //   _showSearchBar = false;
        // });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // setState(() {
        //   _showSearchBar = true;
        // });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
