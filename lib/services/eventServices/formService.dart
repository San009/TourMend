import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class FormService {
  static Future<String> liveEvent(String userEmail, String eventAddress,
      String eventDesc, String eventType, String eventName) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/liveEventForm.php";
      final response = await http.post(url, body: {
        "userEmail": userEmail,
        "eventAddress": eventAddress,
        "eventDesc": eventDesc,
        "eventType": eventType,
        "eventName": eventName,
      });

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['statusCode'];
      } else {
        return 'Error while submitting event!';
      }
    } catch (e) {
      return ('Error in live(): ' + e.toString());
    }
  }

  static Future<String> regularEvent(String userEmail, String eventName,
      String eventAddress, String eventDesc, String from, String to) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/regularEventForm.php";
      final response = await http.post(url, body: {
        "userEmail": userEmail,
        "eventName": eventName,
        "eventAddress": eventAddress,
        "eventDesc": eventDesc,
        "fromDate": from,
        "toDate": to,
      });

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['statusCode'];
      } else {
        return 'Error while submitting event!';
      }
    } catch (e) {
      return ('Error in regular(): ' + e.toString());
    }
  }
}
