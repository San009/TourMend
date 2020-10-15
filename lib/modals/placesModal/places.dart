class PlacesData {
  String id;
  String name;
  String destination;
  String image;
  String info;
  String itinerary;
  String map;

  PlacesData(
      {this.id,
      this.name,
      this.destination,
      this.image,
      this.info,
      this.itinerary,
      this.map});

  factory PlacesData.fromJson(Map<String, dynamic> json) {
    return PlacesData(
      id: json['id'],
      name: json['name'],
      destination: json['destination'],
      image: json['image'],
      info: json['info'],
      itinerary: json['itinerary'],
      map: json['map'],
    );
  }
}
