class ProfileData {
  String id;
  String userName;
  String image;

  ProfileData({
    this.id,
    this.userName,
    this.image,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'],
      userName: json['userName'],
      image: json['image'],
    );
  }
}
