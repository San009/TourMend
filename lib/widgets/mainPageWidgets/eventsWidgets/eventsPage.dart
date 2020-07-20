import 'package:flutter/material.dart';
import 'formWidget/Reportevent.dart';

/// This Widget is the main application widget.
class EventPage extends StatelessWidget {
  final titles = [
    'bike',
    'boat',
    'bus',
    'car',
    'railway',
    'run',
    'subway',
    'transit',
    'walk'
  ];

  final icons = [
    Icons.directions_bike,
    Icons.directions_boat,
    Icons.directions_bus,
    Icons.directions_car,
    Icons.directions_railway,
    Icons.directions_run,
    Icons.directions_subway,
    Icons.directions_transit,
    Icons.directions_walk
  ];

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
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
            //                           <-- Card widget
            child: ListTile(
              leading: CircleAvatar(child: Icon(icons[index])),
              title: Text(titles[index]),
              subtitle: Text("subtitle"),
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
