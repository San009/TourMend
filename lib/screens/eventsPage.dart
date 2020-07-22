import 'package:flutter/material.dart';
import 'package:flutter_app/modals/eventModal/events.dart';
import 'package:flutter_app/services/eventService/fetchEvents.dart';
import '../widgets/eventsWidgets/formWidget/reportEvents.dart';

/// This Widget is the main application widget.

class EventsPage extends StatefulWidget {
  final String title;

  EventsPage({Key key, this.title}) : super(key: key);
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventsPage> {
  List<EventData> eventsData = List();
  List<EventData> filtreddata = List();
  ScrollController _scrollController;
  int pageNumber;
  bool isLoading;
  @override
  void initState() {
    eventsData = filtreddata;
    super.initState();
    _scrollController = ScrollController();
    pageNumber = 1;
    isLoading = true;

    fetchEvents().then((result) {
      for (var place in result) {
        eventsData.add(place);
        setState(() {
          isLoading = false;
        });
      }
    });

    _scrollController.addListener(() {
      // print(_scrollController.position.extentAfter);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          pageNumber++;
        });
        fetchEvents().then((result) {
          if (result != null) {
            for (var place in result) {
              eventsData.add(place);
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
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.event_available,
            size: 35,
            color: Colors.blue,
          ),
          title: Text(
            'All Events ',
            style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: "BioRhyme",
                color: Colors.black),
          )),
      body: Container(
        child: FutureBuilder<List<EventData>>(
          initialData: eventsData,
          future: fetchEvents(),
          builder: (context, snapshot) {
            if (isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                itemCount: eventsData.length,
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (snapshot.data != null) {
                    if (snapshot.data.length + 1 == index) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                  return Card(
                    elevation: 10.0,
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 4.0),
                      child: Column(children: <Widget>[
                        Row(children: <Widget>[
                          Padding(
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 18.0,
                                child: Icon(
                                  Icons.people,
                                  size: 20.0,
                                ),
                              ),
                              padding: EdgeInsets.all(1.0)),
                          Padding(
                              child: Text(
                                "Username ",
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.right,
                              ),
                              padding: EdgeInsets.all(1.0)),
                          Padding(
                              child: Icon(
                                Icons.chevron_right,
                                size: 20.0,
                              ),
                              padding: EdgeInsets.all(1.0)),
                          Padding(
                              child: Text(
                                eventsData[index].eventType,
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                                textAlign: TextAlign.right,
                              ),
                              padding: EdgeInsets.all(1.0)),
                          Text(" | "),
                          Padding(
                              child: Text(
                                eventsData[index].eventName,
                                style:
                                    new TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.right,
                              ),
                              padding: EdgeInsets.all(1.0)),
                        ]),
                        Row(children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 59.0, right: 37, top: 0),
                            child: Text(
                              "From ",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Text(" | "),
                          Padding(
                              child: Text(
                                eventsData[index].eventAddress,
                                style:
                                    new TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.right,
                              ),
                              padding: EdgeInsets.all(1.0)),
                        ]),

                        Row(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 55.0,
                              top: 3,
                            ),
                            child: Text(
                              "Event Date ",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(" | "),
                          Padding(
                              child: Text(
                                eventsData[index].fromDate,
                                style:
                                    new TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.right,
                              ),
                              padding: EdgeInsets.all(1.0)),
                          Padding(
                              child: Text(
                                "To",
                                style:
                                    new TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.right,
                              ),
                              padding: EdgeInsets.all(1.0)),
                          Padding(
                              child: Text(
                                eventsData[index].toDate,
                                style:
                                    new TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.right,
                              ),
                              padding: EdgeInsets.all(1.0)),
                        ]),

                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Image.network(
                            'http://10.0.2.2/TourMendWebServices/placesimage/eventsbanner.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, top: 3),
                            child: Text(
                              eventsData[index].description,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ]),

                        // Divider(color: Colors.black),
                      ]),
                    ),
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReportPage(),
              ));
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<List<EventData>> fetchEvents() {
    return FetchEvents.fetchEvents(pageNumber: pageNumber)
        .then((value) => value.places);
  }
}
