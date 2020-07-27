import 'package:flutter/material.dart';

class JsonListView extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final ScrollController scrollController;
  final List listData;
  final Function onTapWidget, childWidget;

  JsonListView({
    @required this.snapshot,
    @required this.scrollController,
    @required this.listData,
    this.onTapWidget,
    @required this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listData.length,
      controller: scrollController,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (snapshot.data != null) {
          if (snapshot.data.length + 1 == index + 1) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
        return GestureDetector(
          onTap: () {
            if (onTapWidget != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => onTapWidget(index),
                ),
              );
            }
          },
          child: childWidget(index),
        );
      },
    );
  }
}
