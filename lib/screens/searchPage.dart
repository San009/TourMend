import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../widgets/jsonListViewWidget/jsonListView.dart';
import '../widgets/placesPageWidgets/placeCard.dart';
import '../widgets/placesPageWidgets/nestedTabBar.dart';
import '../services/fetchPlaces.dart';
import '../modals/placesModal/places.dart';

class SearchPage extends StatefulWidget {
  final String searchString;
  final int selectedIndex;

  SearchPage(
      {Key key, @required this.searchString, @required this.selectedIndex})
      : super(key: key);
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
      } else
        setState(() {
          isLoading = false;
        });
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

            if (placesData.isEmpty) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      'http://10.0.2.2/TourMendWebServices/Images/noresult.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'Oops!\nNo result found!.',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
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
    // check seletedIndex and retrun different search result
    return FetchPlaces.search(widget.searchString, pageNumber: pageNumber)
        .then((value) => value.places);
  }
}
