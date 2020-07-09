import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:photo_view/photo_view.dart';

class PlacesPage extends StatefulWidget {
  PlacesPage({Key key}) : super(key: key);

  @override
  PlacesPageState createState() => PlacesPageState();
}

class PlacesPageState extends State<PlacesPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: JsonListView(),
      ),
    );
  }
}

class Placesdata {
  String id;
  String pName;
  String dst;
  String placesImageURL;
  String info;
  String itinerary;
  String map;

  Placesdata(
      {this.id,
      this.pName,
      this.dst,
      this.placesImageURL,
      this.info,
      this.itinerary,
      this.map});

  factory Placesdata.fromJson(Map<String, dynamic> json) {
    return Placesdata(
        id: json['id'],
        pName: json['placename'],
        dst: json['dst'],
        placesImageURL: json['placeimage'],
        info: json['info'],
        itinerary: json['Itinerary'],
        map: json['map']);
  }
}

class JsonListView extends StatefulWidget {
  JsonListViewWidget createState() => JsonListViewWidget();
}

class JsonListViewWidget extends State<JsonListView> {
  static int page = 1;
  bool isLoading = false;
  List<Placesdata> movies;
  Future<List> places;
  Future<List<Map<String, dynamic>>> future;
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    places = this.fetchPlaces(page);
    _scrollController.addListener(() {
      print(_scrollController.position.extentAfter);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          page++;
          print("PAGE NUMBER $page");
          print("getting data");
          fetchPlaces(page);
          // getProducts(false)
        });
        // fetchPlaces(page);

        //fetchPlaces(page);
      }
    });
    // places = this.fetchPlaces(page);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<Placesdata>>(
        future: places,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data != null) {
            return buildListView(snapshot);
          }
        });
  }

  Future<List<Placesdata>> fetchPlaces(int i) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var response = await http.get(
          "http://10.0.2.2/TourMendWebServices/place.php?page_number=" +
              i.toString());

      await new Future.delayed(new Duration(seconds: 2));
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        // List tList = new List();
        List<Placesdata> placedata = items.map<Placesdata>((json) {
          return Placesdata.fromJson(json);
        }).toList();

        return placedata;
      } else {
        throw Exception('Failed to load data.');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  ListView buildListView(AsyncSnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length + 1,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemBuilder: (context, index) {
          if (snapshot.data.length == index) {
            return _buildProgressIndicator();
          }

          return GestureDetector(
              onTap: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new NestedTabBar(value: snapshot.data[index]),
                );
                //A Navigator is a widget that manages a set of child widgets with
                //stack discipline.It allows us navigate pages.
                Navigator.of(context).push(route);
              },
              child: new Container(
                padding: EdgeInsets.all(3.0),
                margin: EdgeInsets.all(3.0),
                child: Column(children: <Widget>[
                  Padding(
                    child: Image.network(
                      snapshot.data[index].placesImageURL,
                      fit: BoxFit.cover,
                    ),
                    padding: EdgeInsets.only(bottom: 2.0),
                  ),
                  Row(children: <Widget>[
                    Padding(
                        child: Text(
                          snapshot.data[index].pName,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.right,
                        ),
                        padding: EdgeInsets.all(1.0)),
                    Text(" | "),
                    Padding(
                        child: Text(
                          snapshot.data[index].dst,
                          style: new TextStyle(fontStyle: FontStyle.italic),
                          textAlign: TextAlign.right,
                        ),
                        padding: EdgeInsets.all(1.0)),
                  ]),
                  Divider(color: Colors.black),
                ]),
              ));
        });
  }
}

class NestedTabBar extends StatefulWidget {
  @override
  final Placesdata value;
  NestedTabBar({Key key, this.value}) : super(key: key);
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();

    _nestedTabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        /* appBar: AppBar(
            title: Text(
          '${widget.value.pName}',
          style: TextStyle(fontSize: 20.0),
        )),*/
        body: SingleChildScrollView(
      child: new Center(
        child: Column(children: <Widget>[
          Padding(
            child: Image.network(
              '${widget.value.placesImageURL}',
              fit: BoxFit.cover,
              height: 250,
            ),
            padding: EdgeInsets.only(
              bottom: 2.0,
            ),
          ),
          nestedTabBar(),
        ]),
      ),
    ));
  }

  @override
  Widget nestedTabBar() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.teal,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: <Widget>[
            Tab(
              text: "Info",
            ),
            Tab(
              text: "Itinerary",
            ),
            Tab(
              text: "Map",
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.80,
          margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              Container(
                child: Text(
                  '${widget.value.info}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Container(
                child: Text(
                  '${widget.value.itinerary}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              new PhotoView(
                  imageProvider: NetworkImage(
                    '${widget.value.map}',
                  ),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: 4.0),
            ],
          ),
        )
      ],
    );
  }
}
