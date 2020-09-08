import 'dart:convert';
import '../modals/newsModal/newsList.dart';
import '../modals/newsModal/news.dart';
import 'package:http/http.dart' as http;

class FetchNews {
  static Future<NewsList> fetchnews({int pageNumber}) async {
    final news = List<NewsData>();
    try {
      final url =
          "http://10.0.2.2/TourMendWebServices/newsJson.php?page_number=" +
              pageNumber.toString();
      final response = await http.get(url);

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respJson['news'] != null) {
          for (var newS in respJson['news']) {
            var newsData = NewsData(
              headLine: newS['headLine'],
              id: newS['id'],
              image: newS['image'],
              des: newS['des'],
            );

            news.add(newsData);
          }
          return NewsList(
            news: news,
            message: respJson['message'],
            statusCode: respJson['statusCode'],
          );
        } else
          return NewsList(
              news: null,
              message: respJson['message'],
              statusCode: respJson['statusCode']);
      } else {
        return NewsList(
            news: null,
            message: respJson['message'],
            statusCode: respJson['statusCode']);
      }
    } catch (e) {
      return NewsList(
        news: null,
        message: "Exception: " + e.toString(),
        statusCode: 'Error',
      );
    }
  }

  static Future<NewsList> search(String search, {int pageNumber}) async {
    final news = List<NewsData>();

    try {
      var response = await http.get(Uri.encodeFull(
          "http://10.0.2.2/TourMendWebServices/searchList.php?keyword=" +
              search.toString() +
              "&page_number=" +
              pageNumber.toString()));
      print(search);
      print(pageNumber);
      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respJson['places'] != null) {
          for (var news in respJson['places']) {
            var placeData = NewsData(
              headLine: news['headLine'],
              id: news['id'],
              image: news['img'],
            );

            news.add(placeData);
          }
          return NewsList(
            news: news,
            message: respJson['message'],
            statusCode: respJson['statusCode'],
          );
        } else
          return NewsList(
              news: null,
              message: respJson['message'],
              statusCode: respJson['statusCode']);
      } else {
        return NewsList(
            news: null,
            message: respJson['message'],
            statusCode: respJson['statusCode']);
      }
    } catch (e) {
      return NewsList(
        news: null,
        message: "Exception: " + e.toString(),
        statusCode: 'Error',
      );
    }
  }
}
