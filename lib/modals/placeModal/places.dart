class PlacesData {
  String id;
  String placeName;
  String destination;
  String placesImageURL;
  String info;
  String itinerary;
  String map;

  PlacesData(
      {this.id,
      this.placeName,
      this.destination,
      this.placesImageURL,
      this.info,
      this.itinerary,
      this.map});

  factory PlacesData.fromJson(Map<String, dynamic> json) {
    return PlacesData(
      id: json['id'],
      placeName: json['placeName'],
      destination: json['destination'],
      placesImageURL: json['imgURL'],
      info: json['info'],
      itinerary: json['itinerary'],
      map: json['map'],
    );
  }
}
