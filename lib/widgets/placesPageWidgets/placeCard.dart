import 'package:flutter/material.dart';
import '../../modals/placesModal/places.dart';

class PlaceCard extends StatelessWidget {
  final List<PlacesData> placesData;
  final int index;

  PlaceCard({
    @required this.placesData,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Image.network(
              'http://10.0.2.2/TourMendWebServices/Images/places/${placesData[index].image}',
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 15.0,
                  bottom: 10.0,
                ),
                child: Text(
                  placesData[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 10.0),
                child: Text(" | "),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0, bottom: 10.0),
                child: Text(
                  placesData[index].destination,
                  style: new TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
