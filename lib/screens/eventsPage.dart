import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/eventsWidgets/reportEvent.dart';
import '../modals/eventsModal/events.dart';
import '../services/eventServices/fetchEvents.dart';
import '../services/getUserInfo.dart';
import '../widgets/eventsWidgets/eventCard.dart';
import '../widgets/jsonListViewWidget/jsonListView.dart';

class EventsPage extends StatefulWidget {
  final String title;

  EventsPage({Key key, this.title}) : super(key: key);
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventsPage> {
  SharedPreferences preferences;
  List<EventsData> eventsData = List();
  ScrollController _scrollController;
  int _pageNumber;
  bool _isLoading, _showButton;
  String userImage;

  bool _showSearchBar;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _showSearchBar = true;
    _pageNumber = 1;
    _isLoading = true;
    _showButton = true;

    _fetchEvents().then((result) {
      if (result != null) {
        setState(() {
          _isLoading = false;
        });
        for (var event in result) {
          eventsData.add(event);
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
        _fetchEvents().then((result) {
          if (result != null) {
            for (var event in result) {
              eventsData.add(event);
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
      body: RefreshIndicator(
        onRefresh: () => _fetchEvents().then((value) {
          // do something
        }),
        child: Container(
          padding: _showSearchBar
              ? EdgeInsets.only(top: 55.0)
              : EdgeInsets.only(top: 0.0),
          child: FutureBuilder<List<EventsData>>(
            initialData: eventsData,
            future: _fetchEvents(),
            builder: (context, snapshot) {
              if (_isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return JsonListView(
                snapshot: snapshot,
                listData: eventsData,
                scrollController: _scrollController,
                childWidget: (value) => EventCard(
                  eventsData: eventsData,
                  index: value,
                  userImage: userImage,
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: _showButton,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportEventPage(),
                ));
          },
          label: Text(
            'Add Event',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  Future<List<EventsData>> _fetchEvents() {
    return FetchEvents.fetchEvents(pageNumber: _pageNumber)
        .then((value) => value.events);
  }

  void _handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          _scrollController.position.pixels >= 36) {
        setState(() {
          _showButton = false;
          _showSearchBar = false;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _showButton = true;
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
