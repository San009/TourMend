import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class EditInfo {
  static Future<String> edit(String username, String password) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/editProfile.php";
      //post data into the url
      final response = await http
          .post(url, body: {"username": username, "password": password});

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['statusCode'];
      } else {
        return 'Registering failed due to server error!';
      }
    } catch (e) {
      return "Error!" + e.toString();
    }
  }
}
