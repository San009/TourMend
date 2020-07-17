import 'dart:convert';
import '../widgets/mainPageWidgets/placesWidgets/modal/placesList.dart';
import '../widgets/mainPageWidgets/placesWidgets/modal/places.dart';
import 'package:http/http.dart' as http;

class FetchPlaces {
  static Future<PlacesList> fetchPlaces({int pageNumber}) async {
    final places = List<PlacesData>();
    try {
      final url =
          "http://10.0.2.2/TourMendWebServices/placesJson.php?page_number=" +
              pageNumber.toString();
      final response = await http.get(url);

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respJson['places'] != null) {
          for (var place in respJson['places']) {
            var placeData = PlacesData(
              placeName: place['placeName'],
              id: place['id'],
              placesImageURL: place['imgURL'],
              destination: place['destination'],
              map: place['map'],
              info: place['info'],
              itinerary: place['itinerary'],
            );

            places.add(placeData);
          }
          return PlacesList(
            places: places,
            message: respJson['message'],
            statusCode: respJson['statusCode'],
          );
        } else
          return PlacesList(
              places: null,
              message: respJson['message'],
              statusCode: respJson['statusCode']);
      } else {
        return PlacesList(
            places: null,
            message: respJson['message'],
            statusCode: respJson['statusCode']);
      }
    } catch (e) {
      return PlacesList(
        places: null,
        message: "Exception: " + e.toString(),
        statusCode: 'Error',
      );
    }
  }
}
