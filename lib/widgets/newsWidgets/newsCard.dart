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
    if (newsData[index].image != 'none') {
      return Container(
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: Card(
            elevation: 2.0,
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0, left: 10),
                      child: Image.network(
                        'http://10.0.2.2/TourMendWebServices/Images/news/${newsData[index].image}',
                        height: 100,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    new Column(children: <Widget>[
                      new SizedBox(
                        height: 80.0,
                        width: 230.0,
                        child: new Container(
                          padding: EdgeInsets.only(left: 9),
                          child: Text(
                            newsData[index].headLine,
                            maxLines: 3,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Row(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 182.0, bottom: 0),
                          child: Icon(
                            Icons.mode_comment,
                            color: Colors.green,
                            size: 15,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 1.0,
                          ),
                          child: Text(
                            "100k",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.green),
                          ),
                        ),
                      ])
                    ])
                  ]),
            ])),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: Card(
            elevation: 2.0,
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      newsData[index].headLine,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.left,
                      maxLines: 3,
                    ),
                  )),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 3.0, bottom: 7),
                  child: Icon(
                    Icons.mode_comment,
                    color: Colors.green,
                    size: 15,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.0, bottom: 7),
                  child: Text(
                    "100k",
                    style: TextStyle(fontSize: 15.0, color: Colors.green),
                  ),
                )
              ])
            ])),
      );
    }
  }
}
/*   new Column(
                      children: <Widget>[
                        new SizedBox(
                          height: 80.0,
                          width: 230.0,
                          child: new Container(
                            padding: EdgeInsets.only(left: 9),
                            child: Text(
                              newsData[index].headLine,
                              maxLines: 3,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 3.0, bottom: 7),
                                child: Icon(Icons.comment),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5.0, bottom: 7),
                                child: Text("100k"),
                              )
                            ])
                      ],
                    ), */
