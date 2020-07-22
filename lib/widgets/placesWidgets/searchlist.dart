import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'nestedTabBar.dart';
import '../../services/fetchPlaces.dart';
import '../../modals/placeModal/places.dart';

class SearchPage extends StatefulWidget {
  final String tvalue;

  SearchPage({Key key, this.tvalue}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<PlacesData> placesData = List();
  ScrollController _scrollController;
  int pageNumber;
  bool isLoading;
  @override
  void initState() {
    //   placesData = filtreddata;
    super.initState();
    _scrollController = ScrollController();
    pageNumber = 1;
    isLoading = true;

    search().then((result) {
      if (result != null) {
        for (var place in result) {
          placesData.add(place);
          setState(() {
            isLoading = false;
          });
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(children: [
                Image.network(
                  'http://10.0.2.2/TourMendWebServices/PlacesImage/noresult.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                Text('OPS!\n No result found!. ')
              ]),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });

    _scrollController.addListener(() {
      // print(_scrollController.position.extentAfter);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          pageNumber++;
        });
        search().then((result) {
          if (result != null) {
            for (var place in result) {
              placesData.add(place);
            }
          }
        });
      }
    });
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text("Your search result"),
      ),
      body: Container(
        child: FutureBuilder<List<PlacesData>>(
          initialData: placesData,
          future: search(),
          builder: (context, snapshot) {
            if (isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                itemCount: placesData.length,
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NestedTabBar(
                            placeData: placesData[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 10.0,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 4.0),
                        child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Image.network(
                              placesData[index].placesImageURL,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(children: <Widget>[
                            Padding(
                                child: Text(
                                  placesData[index].placeName,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  textAlign: TextAlign.right,
                                ),
                                padding: EdgeInsets.all(1.0)),
                            Text(" | "),
                            Padding(
                                child: Text(
                                  placesData[index].destination,
                                  style: new TextStyle(
                                      fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.right,
                                ),
                                padding: EdgeInsets.all(1.0)),
                          ]),
                          // Divider(color: Colors.black),
                        ]),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }

  Future<List<PlacesData>> search() {
    return FetchPlaces.search(widget.tvalue, pageNumber: pageNumber)
        .then((value) => value.places);
  }
}
