class NewsData {
  String id;
  String headLine;
  String image;
  String des;

  NewsData({this.id, this.headLine, this.image, this.des});

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      id: json['id'],
      headLine: json['headLine'],
      image: json['image'],
      des: json['des'],
    );
  }
}
