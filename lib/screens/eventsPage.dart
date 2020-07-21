import 'package:flutter/material.dart';
import '../widgets/eventsWidgets/formWidget/reportEvents.dart';

/// This Widget is the main application widget.
class EventPage extends StatelessWidget {
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
      body: ListView.builder(
        //itemCount: titles.length,
        itemBuilder: (context, index) {
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
                        "Event Type ",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)),
                  Text(" | "),
                  Padding(
                      child: Text(
                        "Event name",
                        style: new TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)),
                ]),
                Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 59.0, right: 37, top: 0),
                    child: Text(
                      "From ",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Text(" | "),
                  Padding(
                      child: Text(
                        "Address",
                        style: new TextStyle(fontStyle: FontStyle.italic),
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
                        "DD/MM/YY",
                        style: new TextStyle(fontStyle: FontStyle.italic),
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
                      "Description : ",
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
        },
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
}
