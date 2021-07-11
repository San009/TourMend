class UserInfo {
  String userEmail;
  String userName;
  String userImage;
  String statusCode;

  UserInfo({
    this.userEmail,
    this.userName,
    this.userImage,
    this.statusCode,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userName: json['userName'],
      userImage: json['image'],
      statusCode: json['statusCode'],
    );
  }
}
