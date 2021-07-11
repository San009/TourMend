import 'package:flutter/material.dart';
import '../../modals/newsModal/news.dart';

class NewsCard extends StatelessWidget {
  final List<NewsData> newsData;
  final int index;

  NewsCard({
    @required this.newsData,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
      child: Card(
        elevation: 6.0,
        margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: <Widget>[
                (newsData[index].image != 'none')
                    ? Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Image.network(
                          'http://10.0.2.2/TourMendWebServices/Images/news/${newsData[index].image}',
                          height: 100,
                          width: 130,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 90.0,
                  width: (newsData[index].image != 'none') ? 210.0 : 360.0,
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                      left: (newsData[index].image != 'none') ? 5.0 : 12.0,
                      right: (newsData[index].image != 'none') ? 8.0 : 12.0,
                      top: 10.0,
                    ),
                    child: Text(
                      newsData[index].headLine,
                      maxLines: 3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[500],
                                offset: Offset(2.0, 2.0),
                                blurRadius: 2.0,
                                spreadRadius: 0.0)
                          ],
                          border: Border.all(
                            color: Colors.grey[600],
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 5.0, top: 5.0, left: 8.0),
                            child: Icon(
                              Icons.thumb_up,
                              color: Colors.green,
                              size: 15,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5.0,
                              bottom: 5.0,
                              top: 5.0,
                              right: 8.0,
                            ),
                            child: Text(
                              "100k",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 10.0, left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[500],
                                offset: Offset(2.0, 2.0),
                                blurRadius: 2.0,
                                spreadRadius: 0.0)
                          ],
                          border: Border.all(
                            color: Colors.grey[600],
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 5.0, top: 5.0, left: 8.0),
                            child: Icon(
                              Icons.mode_comment,
                              color: Colors.blueAccent,
                              size: 15,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5.0,
                              bottom: 5.0,
                              top: 5.0,
                              right: 8.0,
                            ),
                            child: Text(
                              "100k",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
