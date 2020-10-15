import 'dart:convert';
import '../modals/galleryModal/gallery.dart';
import '../modals/galleryModal/galleryList.dart';
import 'package:http/http.dart' as http;

class FetchGallery {
  static Future<GalleryList> fetchGallery({int pageNumber}) async {
    final galleryList = List<GalleryData>();
    try {
      final url =
          "http://10.0.2.2/TourMendWebServices/galleryJson.php?page_number=" +
              pageNumber.toString();

      final response = await http.get(url);
      final respJson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (respJson['Gallery'] != null) {
          for (var gallery in respJson['Gallery']) {
            var galleryData = GalleryData(
              id: gallery['id'],
              userName: gallery['userName'],
              userImage: gallery['userImage'],
              image: gallery['image'],
              description: gallery['description'],
            );

            galleryList.add(galleryData);
          }
          return GalleryList(
            gallery: galleryList,
            message: respJson['message'],
            statusCode: respJson['statusCode'],
          );
        } else {
          return GalleryList(
              gallery: null,
              message: respJson['message'],
              statusCode: respJson['statusCode']);
        }
      } else {
        return GalleryList(
            gallery: null,
            message: respJson['message'],
            statusCode: respJson['statusCode']);
      }
    } catch (e) {
      return GalleryList(
        gallery: null,
        message: "Exception: " + e.toString(),
        statusCode: 'Error',
      );
    }
  }
}
