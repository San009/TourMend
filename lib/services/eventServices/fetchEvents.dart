import 'dart:convert';
import '../../modals/eventsModal/events.dart';
import '../../modals/eventsModal/eventsList.dart';
import 'package:http/http.dart' as http;

class FetchEvents {
  static Future<EventsList> fetchEvents({int pageNumber}) async {
    final events = List<EventsData>();
    try {
      final url =
          "http://10.0.2.2/TourMendWebServices/eventsJson.php?page_number=" +
              pageNumber.toString();
      final response = await http.get(url);

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respJson['events'] != null) {
          for (var event in respJson['events']) {
            var eventData = EventsData(
              id: event['id'],
              userName: event['userName'],
              eventType: event['eventType'],
              eventName: event['eventName'],
              eventAddress: event['eventAddress'],
              fromDate: event['fromDate'],
              toDate: event['toDate'],
              eventImage: event['eventImage'],
              eventDesc: event['eventDesc'],
            );

            events.add(eventData);
          }
          return EventsList(
            events: events,
            message: respJson['message'],
            statusCode: respJson['statusCode'],
          );
        } else
          return EventsList(
              events: null,
              message: respJson['message'],
              statusCode: respJson['statusCode']);
      } else {
        return EventsList(
            events: null,
            message: respJson['message'],
            statusCode: respJson['statusCode']);
      }
    } catch (e) {
      return EventsList(
        events: null,
        message: "Exception: " + e.toString(),
        statusCode: 'Error',
      );
    }
  }
}
