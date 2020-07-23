import 'package:flutter/material.dart';
import 'regularEventWidgets/regularEvents.dart';
import 'liveEvents.dart';
//import '../eventsPage.dart';

class ReportPage extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<ReportPage>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();

    _nestedTabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Report Events Happening',
            style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: "BioRhyme",
                color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
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
              text: "Live Events",
            ),
            Tab(
              text: "Regular Events",
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.70,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              LiveeventsPage(),
              RegularEventsPage(),
            ],
          ),
        )
      ],
    );
  }
}
