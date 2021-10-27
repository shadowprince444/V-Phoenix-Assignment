import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:timesofindia/constants.dart';
import 'package:timesofindia/models/news_article_model.dart';
import 'package:timesofindia/view_models/news_article_vm.dart';

class NewsArticleRepo {
  fetchRepo(BuildContext context) {
    final newsArticleVm = Provider.of<NewsArticleVM>(context, listen: false);
    try {
      Uri uri = Uri.http(Constants.authority, Constants.unencodedPath);
      http.get(uri).then((value) {
        if (value.statusCode == 200) {
          Map<String, dynamic> decodedResponse = jsonDecode(value.body);
          NewsArticlesModel newsArticlesModel =
              NewsArticlesModel.fromJson(decodedResponse);
          newsArticleVm.updateNewsArticleList(newsArticlesModel);
        }
      });
    } on SocketException catch (e) {
      rethrow;
    }
  }
}
