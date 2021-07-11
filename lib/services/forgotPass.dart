import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotPass {
  static Future<String> onSubmitEmail({String email}) async {
    try {
      final url = "http://10.0.2.2/TourMendWebServices/forgotPass.php";
      final response = await http.post(url, body: {
        "email": email,
      });

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['statusCode'];
      } else {
        return respJson['statusCode'];
      }
    } catch (e) {
      return ('Error: ' + e.toString());
    }
  }

  static Future<String> onSubmit(
      {String email, String label2, String data2, String fileName}) async {
    try {
      final url = "http://10.0.2.2/TourMendWebServices/" + fileName + ".php";
      final response = await http.post(url, body: {
        "email": email,
        label2: data2,
      });

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['statusCode'];
      } else {
        return respJson['statusCode'];
      }
    } catch (e) {
      return ('Error: ' + e.toString());
    }
  }
}
