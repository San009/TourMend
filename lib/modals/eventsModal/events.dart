class EventsData {
  String id;
  String userName;
  String eventType;
  String eventName;
  String eventAddress;
  String fromDate;
  String toDate;
  String eventImage;
  String eventDesc;

  EventsData(
      {this.id,
      this.userName,
      this.eventType,
      this.eventName,
      this.eventAddress,
      this.fromDate,
      this.toDate,
      this.eventImage,
      this.eventDesc});

  factory EventsData.fromJson(Map<String, dynamic> json) {
    return EventsData(
      id: json['id'],
      userName: json['userName'],
      eventType: json['eventType'],
      eventName: json['eventName'],
      eventAddress: json['eventAddress'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      eventImage: json['eventImage'],
      eventDesc: json['eventDesc'],
    );
  }
}
