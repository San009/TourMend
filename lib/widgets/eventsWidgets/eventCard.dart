import 'package:flutter/material.dart';
import 'package:flutter_app/modals/eventsModal/events.dart';

class EventCard extends StatelessWidget {
  final List<EventsData> eventsData;
  final int index;
  final String userImage;

  EventCard({
    this.eventsData,
    this.index,
    this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 18.0, top: 15.0),
                  child: (userImage == null)
                      ? CircleAvatar(
                          child: Icon(Icons.person),
                          backgroundColor: Colors.blueAccent,
                          radius: 20.0,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://10.0.2.2/TourMendWebServices/Images/profileImages/${eventsData[index].userImage}'),
                          radius: 20.0,
                        )),
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 15.0),
                child: Text(
                  'Posted by',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.grey[700]),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0, top: 15.0),
                child: Text(
                  eventsData[index].userName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.black),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 19.0),
                child: Text(
                  ".. min ago",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.grey[600]),
                  textAlign: TextAlign.justify,
                ),
              ),
            ]),
            Row(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: (eventsData[index].eventType != 'Other' &&
                          eventsData[index].eventName == 'none')
                      ? Text(
                          eventsData[index].eventType,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0,
                          ),
                        )
                      : Text(
                          eventsData[index].eventName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                          textAlign: TextAlign.right,
                        ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                  child: Text(
                    "Location : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.grey[600]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, top: 2.0, bottom: 5.0),
                  child: Text(
                    eventsData[index].eventAddress,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            (eventsData[index].eventType != 'Other' &&
                    eventsData[index].eventName == 'none')
                ? Container()
                : Row(children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, top: 8.0, bottom: 5.0),
                      child: Text(
                        "Event Date : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.grey[600]),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, right: 2.0, left: 10.0, bottom: 5.0),
                      child: Text(
                        eventsData[index].fromDate,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
                      child: Text(
                        "to",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 2.0, left: 3.0),
                      child: Text(
                        eventsData[index].toDate,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black),
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Row(children: <Widget>[
                Flexible(
                  child: Text(
                    eventsData[index].eventDesc,
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
        ),
      ),
    );
  }
}
