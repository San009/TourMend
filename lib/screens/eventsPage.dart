import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/modals/eventsModal/events.dart';
import 'package:flutter_app/services/eventServices/fetchEvents.dart';
import 'package:flutter_app/widgets/eventsWidgets/eventCard.dart';
import 'package:flutter_app/widgets/jsonListViewWidget/jsonListView.dart';
import '../widgets/eventsWidgets/reportEvent.dart';

class EventsPage extends StatefulWidget {
  final String title;

  EventsPage({Key key, this.title}) : super(key: key);
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventsPage> {
  List<EventsData> eventsData = List();
  ScrollController _scrollController;
  int _pageNumber;
  bool _isLoading, _showButton;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _pageNumber = 1;
    _isLoading = true;
    _showButton = true;

    _fetchEvents().then((result) {
      for (var event in result) {
        eventsData.add(event);
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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Icon(
              Icons.event_available,
              size: 30,
              color: Colors.black87,
            ),
          ),
          title: Text(
            'All Events ',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black87,
            ),
          )),
      body: Container(
        child: FutureBuilder<List<EventsData>>(
          initialData: eventsData,
          future: _fetchEvents(),
          builder: (context, snapshot) {
            if (_isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return RefreshIndicator(
              onRefresh: () => _fetchEvents().then((value) => null),
              child: JsonListView(
                snapshot: snapshot,
                listData: eventsData,
                scrollController: _scrollController,
                childWidget: (value) => EventCard(
                  eventsData: eventsData,
                  index: value,
                ),
              ),
            );
          },
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
          ScrollDirection.reverse) {
        setState(() {
          _showButton = false;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _showButton = true;
        });
      }
    });
  }
}
