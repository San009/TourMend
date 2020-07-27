import 'package:flutter/material.dart';
import 'regularEventWidgets/regularEvents.dart';
import 'liveEvents.dart';

class ReportEventPage extends StatefulWidget {
  @override
  _ReportEventState createState() => _ReportEventState();
}

class _ReportEventState extends State<ReportEventPage>
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
          title: Text(
            'Report Events',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black87,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: nestedTabBar(),
          ),
        ));
  }

  Widget nestedTabBar() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
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
          height: screenHeight * 0.825,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              LiveEventsPage(),
              RegularEventsPage(),
            ],
          ),
        )
      ],
    );
  }
}
