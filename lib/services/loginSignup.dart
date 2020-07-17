import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class LoginSignup {
  static Future<String> login(String email, String password) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/login.php";
      final response = await http.post(url, body: {
        "email": email,
        "password": password,
      });

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['statusCode'];
      } else {
        return 'Logging in failed due to server error!';
      }
    } catch (e) {
      return ('Error' + e.toString());
    }
  }

  static Future<String> signup(
      String username, String email, String password) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/register.php";
      //post data into the url
      final response = await http.post(url,
          body: {"username": username, "email": email, "password": password});

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['statusCode'];
      } else {
        return respJson['statusCode'];
      }
    } catch (e) {
      return "Error in signup()! " + e.toString();
    }
  }
}
