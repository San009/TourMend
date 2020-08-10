import 'package:flutter/material.dart';
import 'package:flutter_app/modals/eventsModal/events.dart';

class EventCard extends StatelessWidget {
  final List<EventsData> eventsData;
  final int index;

  EventCard({
    this.eventsData,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    if (eventsData[index].eventType != 'Other' &&
        eventsData[index].eventName == 'none') {
      return Container(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
        child: Card(
          elevation: 10.0,
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 12.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, top: 7),
                  child: Text(
                    'posted by',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[600]),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, top: 7.0),
                  child: Text(
                    eventsData[index].userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[600]),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 7),
                  child: Text(
                    "3 min ago",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[600]),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ]),
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 9.0, right: 5.0, top: 9),
                  child: Text(
                    eventsData[index].eventType,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    textAlign: TextAlign.right,
                  ),
                ),
              ]),
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 9.0, right: 5.0),
                  child: Text(
                    "Location : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey[600]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.0, right: 5.0),
                  child: Text(
                    eventsData[index].eventAddress,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey[600]),
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Image.network(
                  'http://10.0.2.2/TourMendWebServices/Images/eventsbanner.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Row(children: <Widget>[
                Flexible(
                  child: Text(
                    eventsData[index].eventDesc,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        color: Colors.grey[700]),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ]),
            ],
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
        child: Card(
          elevation: 10.0,
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 12.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, top: 7),
                  child: Text(
                    'posted by',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[600]),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, top: 7.0),
                  child: Text(
                    eventsData[index].userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[600]),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 7),
                  child: Text(
                    "3 min ago",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[600]),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ]),
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 9.0, right: 5.0),
                  child: Text(
                    eventsData[index].eventName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    textAlign: TextAlign.right,
                  ),
                ),
              ]),
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 5.0),
                  child: Text(
                    "Location : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey[600]),
                  ),
                ),
                Padding(
                    child: Text(
                      eventsData[index].eventAddress,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.grey[600]),
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.all(1.0)),
              ]),
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 7.0,
                    top: 3,
                  ),
                  child: Text(
                    "Event Date : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey[600]),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, right: 2.0, left: 5.0),
                  child: Text(
                    eventsData[index].fromDate,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey[600]),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, right: 2.0, left: 2.0),
                  child: Text(
                    "to",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey[600]),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, right: 2.0, left: 3.0),
                  child: Text(
                    eventsData[index].toDate,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey[600]),
                    textAlign: TextAlign.right,
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Image.network(
                  'http://10.0.2.2/TourMendWebServices/Images/eventsbanner.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                  child: Text(
                    eventsData[index].eventDesc,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.right,
                  ),
                ),
              ]),
            ],
          ),
        ),
      );
    }
  }
}
