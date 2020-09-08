import 'package:http/http.dart' as http;
import 'dart:io';

class GetUserInfo {
  // ignore: missing_return
  static Future<String> uploadImage(File imageFile, String email) async {
    try {
      final uri = Uri.parse(
          "http://10.0.2.2/TourMendWebServices/profileImageUpload.php?email=" +
              email);

      var request = http.MultipartRequest('POST', uri);
      var pic = await http.MultipartFile.fromPath("image", imageFile.path);
      print(email);
      request.files.add(pic);
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Image Uploaded');
      } else {
        print('Image not Uploaded');
        return 'Upload failed due to server error!';
      }
    } catch (e) {
      return "Error!" + e.toString();
    }
  }
}
