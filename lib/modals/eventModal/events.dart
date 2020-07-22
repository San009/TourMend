class EventData {
  String id;
  String eventType;
  String eventName;
  String eventAddress;
  String fromDate;
  String toDate;
  String eventImage;
  String description;

  EventData(
      {this.id,
      this.eventType,
      this.eventName,
      this.eventAddress,
      this.fromDate,
      this.toDate,
      this.eventImage,
      this.description});

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['id'],
      eventType: json['placeName'],
      eventName: json['destination'],
      eventAddress: json['eventAddress'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      eventImage: json['eventImage'],
      description: json['description'],
    );
  }
}
