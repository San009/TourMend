import 'dart:convert';
import 'package:flutter_app/modals/eventModal/events.dart';
import 'package:flutter_app/modals/eventModal/eventsList.dart';

import 'package:http/http.dart' as http;

class FetchEvents {
  static Future<EventList> fetchEvents({int pageNumber}) async {
    final places = List<EventData>();
    try {
      final url =
          "http://10.0.2.2/TourMendWebServices/eventsJson.php?page_number=" +
              pageNumber.toString();
      final response = await http.get(url);

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respJson['places'] != null) {
          for (var event in respJson['places']) {
            var placeData = EventData(
              id: event['id'],
              eventType: event['eventType'],
              eventName: event['eventName'],
              eventAddress: event['eventAddress'],
              fromDate: event['fromDate'],
              toDate: event['toDate'],
              eventImage: event['eventImage'],
              description: event['description'],
            );

            places.add(placeData);
          }
          return EventList(
            places: places,
            message: respJson['message'],
            statusCode: respJson['statusCode'],
          );
        } else
          return EventList(
              places: null,
              message: respJson['message'],
              statusCode: respJson['statusCode']);
      } else {
        return EventList(
            places: null,
            message: respJson['message'],
            statusCode: respJson['statusCode']);
      }
    } catch (e) {
      return EventList(
        places: null,
        message: "Exception: " + e.toString(),
        statusCode: 'Error',
      );
    }
  }
}
