import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Editinfo {
  static Future<String> edit(
      String username, String email, String password) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/editprofile.php";
      //post data into the url
      final response = await http.post(url,
          body: {"username": username, "email": email, "password": password});

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
