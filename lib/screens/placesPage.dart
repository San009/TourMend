import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/widgets/jsonListViewWidget/jsonListView.dart';
import 'package:flutter_app/widgets/placesPageWidgets/placeCard.dart';
import 'package:flutter_app/widgets/placesPageWidgets/nestedTabBar.dart';
import 'package:flutter_app/widgets/placesPageWidgets/searchBar.dart';
import '../services/fetchPlaces.dart';
import '../modals/placesModal/places.dart';
import '../widgets/placesPageWidgets/searchPage.dart';

class PlacesPage extends StatefulWidget {
  final String title;

  PlacesPage({Key key, this.title}) : super(key: key);
  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  TextEditingController _search;
  List<PlacesData> _placesData;
  ScrollController _scrollController;
  int _pageNumber;
  bool _isLoading, _canSearch, _showSearchBar;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _search = TextEditingController();
    _pageNumber = 1;
    _isLoading = true;
    _canSearch = false;
    _showSearchBar = true;
    _placesData = List();

    _fetchPlaces().then((result) {
      for (var place in result) {
        _placesData.add(place);
        setState(() {
          _isLoading = false;
        });
      }
    });

    _scrollController.addListener(() {
      // print(_scrollController.position.extentAfter);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _pageNumber++;
        });
        _fetchPlaces().then((result) {
          if (result != null) {
            for (var place in result) {
              _placesData.add(place);
            }
          }
        });
      }
    });

    _handleScroll();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: _showSearchBar
                ? EdgeInsets.only(top: 55.0)
                : EdgeInsets.only(top: 0.0),
            child: FutureBuilder<List<PlacesData>>(
              initialData: _placesData,
              future: _fetchPlaces(),
              builder: (context, snapshot) {
                if (_isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return JsonListView(
                  snapshot: snapshot,
                  listData: _placesData,
                  scrollController: _scrollController,
                  onTapWidget: (value) => NestedTabBar(
                    placeData: _placesData[value],
                  ),
                  childWidget: (value) => PlaceCard(
                    placesData: _placesData,
                    index: value,
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: _showSearchBar,
            child: SearchBar(
              canSearch: _canSearch,
              searchController: _search,
              onValueChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _canSearch = true;
                  });
                } else {
                  setState(() {
                    _canSearch = false;
                  });
                }
              },
              onSubmit: (value) {
                if (value.isEmpty) {
                  setState(() {
                    _canSearch = false;
                  });
                  return;
                }
                _goToSearch(value);
              },
              onTap: () {
                _goToSearch(_search.text);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<List<PlacesData>> _fetchPlaces() {
    return FetchPlaces.fetchPlaces(pageNumber: _pageNumber)
        .then((value) => value.places);
  }

  void _goToSearch(String value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(
          searchString: value,
        ),
      ),
    );
  }

  void _handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          _scrollController.position.pixels >= 36) {
        setState(() {
          _showSearchBar = false;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _showSearchBar = true;
        });
      }
    });
  }
}
