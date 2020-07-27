import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/screens/placesPage.dart';
import '../jsonListViewWidget/jsonListView.dart';
import 'placeCard.dart';
import 'nestedTabBar.dart';
import '../../services/fetchPlaces.dart';
import '../../modals/placesModal/places.dart';

class SearchPage extends StatefulWidget {
  final String searchString;

  SearchPage({Key key, this.searchString}) : super(key: key);
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

    _search().then((result) {
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
                  'http://10.0.2.2/TourMendWebServices/Images/noresult.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                Text('Oops!\n No result found!. ')
              ]),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => PlacesPage()),
                        (route) => false);
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
        _search().then((result) {
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
      appBar: new AppBar(
        elevation: 10.0,
        title: new Text("Search result"),
      ),
      body: Container(
        child: FutureBuilder<List<PlacesData>>(
          initialData: placesData,
          future: _search(),
          builder: (context, snapshot) {
            if (isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return JsonListView(
              snapshot: snapshot,
              listData: placesData,
              scrollController: _scrollController,
              onTapWidget: (value) => NestedTabBar(
                placeData: placesData[value],
              ),
              childWidget: (value) => PlaceCard(
                placesData: placesData,
                index: value,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<List<PlacesData>> _search() {
    return FetchPlaces.search(widget.searchString, pageNumber: pageNumber)
        .then((value) => value.places);
  }
}
