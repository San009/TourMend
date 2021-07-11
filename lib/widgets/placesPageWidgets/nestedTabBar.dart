import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../modals/placesModal/places.dart';

class NestedTabBar extends StatefulWidget {
  final PlacesData placeData;
  NestedTabBar({Key key, this.placeData}) : super(key: key);
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

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 30.0,
              ),
            ),
            Text(
              'Back',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(children: <Widget>[
          Padding(
            child: Stack(children: <Widget>[
              Image.network(
                'http://10.0.2.2/TourMendWebServices/Images/places/${widget.placeData.image}',
                fit: BoxFit.cover,
                height: 250,
              ),
              Positioned(top: 30, child: _backButton()),
            ]),
            padding: EdgeInsets.only(
              bottom: 2.0,
            ),
          ),
          nestedTabBar(),
        ]),
      ),
    ));
  }

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
                  widget.placeData.info,
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
                  widget.placeData.itinerary,
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
                      'http://10.0.2.2/TourMendWebServices/Images/maps/${widget.placeData.map}'),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: 4.0),
            ],
          ),
        )
      ],
    );
  }
}
