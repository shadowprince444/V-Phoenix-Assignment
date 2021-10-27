import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:timesofindia/models/news_article_model.dart';

class NewsArticleVM with ChangeNotifier {
  File? pickedImageFile;
  NewsArticlesModel? newsArticle;
  updateNewsArticleList(NewsArticlesModel newArticles) {
    newsArticle = newArticles;
    notifyListeners();
  }

  removeImage() {
    pickedImageFile = null;
    notifyListeners();
  }

  setImage(File? file) {
    pickedImageFile = file;
    notifyListeners();
  }
}
