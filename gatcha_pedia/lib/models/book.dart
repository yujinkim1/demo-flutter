class Book {
  String id;
  String title;
  String subtitle;
  String thumbnail;
  String previewLink;

  Book({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.thumbnail,
    required this.previewLink,
  });

  Map toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "thumnail": thumbnail,
        "previewLink": previewLink,
      };

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      thumbnail: json["thumnail"],
      previewLink: json["previewLink"],
    );
  }
}
