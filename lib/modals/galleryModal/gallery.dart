class GalleryData {
  String id;
  String userName;
  String userImage;

  String image;
  String description;

  GalleryData(
      {this.id, this.userName, this.userImage, this.image, this.description});

  factory GalleryData.fromJson(Map<String, dynamic> json) {
    return GalleryData(
      id: json['id'],
      userName: json['userName'],
      userImage: json['userImage'],
      image: json['image'],
      description: json['description'],
    );
  }
}
