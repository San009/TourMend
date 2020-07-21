import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Liveevent {
  static Future<String> live(
      String address, String description, String eventType) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/liveEventForm.php";
      final response = await http.post(url, body: {
        "eventaddress": address,
        "description": description,
        "eventType": eventType,
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
}
