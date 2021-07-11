import 'package:http/http.dart' as http;
import 'dart:convert';

class GetUserInfo {
  static Future<String> getUserName(String email) async {
    try {
      final url =
          "http://10.0.2.2/TourMendWebServices/userInfo.php?email=" + email;
      var response = await http.get(Uri.encodeFull(url));

      var respJson = json.decode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['userName'];
      } else {
        print(respJson['message']);
        return null;
      }
    } catch (e) {
      print('Error in getUserInfo(): ' + e.toString());
      return null;
    }
  }

  static Future<String> getUserImage(String email) async {
    try {
      final url =
          "http://10.0.2.2/TourMendWebServices/userInfo.php?email=" + email;
      var response = await http.get(Uri.encodeFull(url));

      var respJson = json.decode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['image'];
      } else {
        print(respJson['message']);
        return null;
      }
    } catch (e) {
      print('Error in getUserImage(): ' + e.toString());
      return null;
    }
  }
}
