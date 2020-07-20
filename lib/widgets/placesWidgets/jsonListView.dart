import 'package:flutter/material.dart';
import '../../modals/places.dart';

class JsonListView extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final ScrollController scrollController;
  final List<PlacesData> placesData;
  final Widget onTapWidget;

  JsonListView(
      {this.snapshot,
      this.scrollController,
      this.placesData,
      this.onTapWidget});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: placesData.length,
        controller: scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (snapshot.data != null) {
            if (snapshot.data.length + 1 == index) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
          return GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                Padding(
                  child: Image.network(
                    placesData[index].placesImageURL,
                    fit: BoxFit.cover,
                  ),
                  padding: EdgeInsets.only(bottom: 2.0),
                ),
                Row(children: <Widget>[
                  Padding(
                      child: Text(
                        placesData[index].placeName,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)),
                  Text(" | "),
                  Padding(
                      child: Text(
                        placesData[index].destination,
                        style: new TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)),
                ]),
                Divider(color: Colors.black),
              ]),
            ),
          );
        });
  }
}
