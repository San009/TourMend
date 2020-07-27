class PlacesData {
  String id;
  String placeName;
  String destination;
  String placeImage;
  String info;
  String itinerary;
  String map;

  PlacesData(
      {this.id,
      this.placeName,
      this.destination,
      this.placeImage,
      this.info,
      this.itinerary,
      this.map});

  factory PlacesData.fromJson(Map<String, dynamic> json) {
    return PlacesData(
      id: json['id'],
      placeName: json['placeName'],
      destination: json['destination'],
      placeImage: json['img'],
      info: json['info'],
      itinerary: json['itinerary'],
      map: json['map'],
    );
  }
}
