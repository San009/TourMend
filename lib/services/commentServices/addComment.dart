import 'dart:convert';
import 'package:http/http.dart' as http;

class AddComments {
  static Future<String> addComment(
      String comment, String email, String newsId) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/addComment.php";
      final response = await http.post(url, body: {
        "comment": comment,
        "email": email,
        "newsId": newsId,
      });

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['statusCode'];
      } else {
        return respJson['statusCode'];
      }
    } catch (e) {
      return ('Error' + e.toString());
    }
  }
}
