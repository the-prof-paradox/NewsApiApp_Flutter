// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

List<News> newsFromJson(String str) =>
    List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
  News({
    this.newsId,
    this.name,
    this.url,
  });

  String newsId;
  String name;
  String url;

  factory News.fromJson(Map<String, dynamic> json) => News(
        newsId: json["news_id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "news_id": newsId,
        "name": name,
        "url": url,
      };
}
