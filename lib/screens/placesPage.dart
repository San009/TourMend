import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../widgets/placesWidgets/nestedTabBar.dart';
import '../services/fetchPlaces.dart';
import '../modals/placeModal/places.dart';

import '../widgets/placesWidgets/searchlist.dart';

class PlacesPage extends StatefulWidget {
  final String title;

  PlacesPage({Key key, this.title}) : super(key: key);
  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  TextEditingController _search = TextEditingController();
  List<PlacesData> placesData = List();
  List<PlacesData> filtreddata = List();
  ScrollController _scrollController;
  int pageNumber;
  bool isLoading;
  @override
  void initState() {
    placesData = filtreddata;
    super.initState();
    _scrollController = ScrollController();
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
          child: Container(
            margin: EdgeInsets.fromLTRB(18, 2, 18, 2),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(150.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: TextStyle(
                        fontSize: 20.0, height: 1.3, color: Colors.black),
                    controller: _search,
                    onSubmitted: (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(
                          tvalue: value,
                        ),
                      ),
                    ),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Search here",
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(
                            tvalue: _search.text,
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                        radius: 24.0,
                        backgroundColor: Colors.deepPurple,
                        child: Icon(
                          Icons.search,
                          size: 24.0,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
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

  Future<List<PlacesData>> _fetchPlaces() {
    return FetchPlaces.fetchPlaces(pageNumber: pageNumber)
        .then((value) => value.places);
  }
}
