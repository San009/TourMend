class CommentsData {
  String id;
  String userName;
  String userImage;
  String comment;
  String date;
  // String likes;
  // String disklikes;

  CommentsData({
    this.id,
    this.userName,
    this.userImage,
    this.comment,
    this.date,
    // this.likes,
    // this.disklikes,
  });

  factory CommentsData.fromJson(Map<String, dynamic> json) {
    return CommentsData(
      id: json['id'],
      userName: json['userName'],
      userImage: json['userImage'],
      comment: json['comment'],
      date: json['dateTime'],
      // likes: json['likes'],
      // disklikes: json['dislikes'],
    );
  }
}
