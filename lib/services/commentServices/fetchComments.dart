import 'dart:convert';

import '../../modals/commentModal/comments.dart';
import '../../modals/commentModal/commentsList.dart';
import 'package:http/http.dart' as http;

class FetchComments {
  static Future<CommentsList> fetchComments(
      {int pageNumber, String newsId}) async {
    final comments = List<CommentsData>();
    try {
      final url =
          "http://10.0.2.2/TourMendWebServices/commentsJson.php?page_number=" +
              pageNumber.toString() +
              "&news_id=" +
              newsId;
      final response = await http.get(url);

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respJson['comments'] != null) {
          for (var comment in respJson['comments']) {
            var newsData = CommentsData(
              id: comment['id'],
              userName: comment['userName'],
              userImage: comment['userImage'],
              comment: comment['comment'],
              date: comment['date'],
            );

            comments.add(newsData);
          }
          return CommentsList(
            comments: comments,
            message: respJson['message'],
            statusCode: respJson['statusCode'],
          );
        } else
          return CommentsList(
              comments: null,
              message: respJson['message'],
              statusCode: respJson['statusCode']);
      } else {
        return CommentsList(
            comments: null,
            message: respJson['message'],
            statusCode: respJson['statusCode']);
      }
    } catch (e) {
      return CommentsList(
        comments: null,
        message: "Exception: " + e.toString(),
        statusCode: 'Error',
      );
    }
  }
}
