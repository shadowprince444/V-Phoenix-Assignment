import 'package:timesofindia/models/article_model.dart';

class NewsArticlesModel {
  String? status;
  int? totalResults;
  List<Articles> articles = [];

  NewsArticlesModel({this.status, this.totalResults, required this.articles});

  NewsArticlesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles.add(Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['totalResults'] = totalResults;

    data['articles'] = articles.map((v) => v.toJson()).toList();

    return data;
  }
}
