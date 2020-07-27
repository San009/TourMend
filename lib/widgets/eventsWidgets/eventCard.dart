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
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 20.0,
                    child: Icon(
                      Icons.people,
                      size: 25.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    eventsData[index].userName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.chevron_right,
                    size: 20.0,
                  ),
                ),
                eventsData[index].eventType != 'Other' &&
                        eventsData[index].eventName == 'none'
                    ? Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          eventsData[index].eventType,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                          textAlign: TextAlign.right,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          eventsData[index].eventName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                          textAlign: TextAlign.right,
                        ),
                      ),
              ],
            ),
            Row(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 59.0, right: 5.0),
                child: Text(
                  "Location : ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Padding(
                  child: Text(
                    eventsData[index].eventAddress,
                    style: TextStyle(fontStyle: FontStyle.italic),
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
                  "Event Date : ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, right: 2.0, left: 5.0),
                child: Text(
                  eventsData[index].fromDate,
                  style: TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, right: 2.0, left: 2.0),
                child: Text(
                  "to",
                  style: TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, right: 2.0, left: 3.0),
                child: Text(
                  eventsData[index].toDate,
                  style: TextStyle(fontStyle: FontStyle.italic),
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
