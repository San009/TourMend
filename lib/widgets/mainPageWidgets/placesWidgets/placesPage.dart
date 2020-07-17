import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'nestedTabBar.dart';
import '../../../services/fetchPlaces.dart';
import 'modal/places.dart';

class PlacesPage extends StatefulWidget {
  final String title;

  PlacesPage({Key key, this.title}) : super(key: key);
  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  TextEditingController _textController = TextEditingController();

  final _debouncer = Debouncer(milliseconds: 500);
  List<PlacesData> placesData;
  List<PlacesData> filteredPlace = List();
  ScrollController _scrollController;
  int pageNumber;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    placesData = filteredPlace;

    pageNumber = 1;
    isLoading = true;

    _fetchPlaces().then((result) {
      for (var place in result) {
        placesData.add(place);
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
        _fetchPlaces().then((result) {
          if (result != null) {
            for (var place in result) {
              placesData.add(place);
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
      appBar: AppBar(backgroundColor: Colors.white, actions: <Widget>[
        Expanded(
          child: TextField(
            controller: _textController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                hintText: "Search here"),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  filteredPlace = placesData
                      .where((u) => (u.placeName
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          u.destination
                              .toLowerCase()
                              .contains(string.toLowerCase())))
                      .toList();
                });
              });
            },
          ),
        )
      ]),
      body: Container(
        child: FutureBuilder<List<PlacesData>>(
          initialData: placesData,
          future: _fetchPlaces(),
          builder: (context, snapshot) {
            if (isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                itemCount: filteredPlace.length,
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
                            placeData: filteredPlace[index],
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
                              filteredPlace[index].placesImageURL,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(children: <Widget>[
                            Padding(
                                child: Text(
                                  filteredPlace[index].placeName,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  textAlign: TextAlign.right,
                                ),
                                padding: EdgeInsets.all(1.0)),
                            Text(" | "),
                            Padding(
                                child: Text(
                                  filteredPlace[index].destination,
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

  Future<List<PlacesData>> _fetchPlaces() {
    return FetchPlaces.fetchPlaces(pageNumber: pageNumber)
        .then((value) => value.places);
  }
}
