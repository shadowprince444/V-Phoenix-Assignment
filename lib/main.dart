import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesofindia/view/screens/loading_screen.dart';
import 'package:timesofindia/view_models/news_article_vm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<NewsArticleVM>(
            create: (context) => NewsArticleVM(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            //

            primarySwatch: Colors.blue,
          ),
          home: const LoadingScreen(),
        ));
  }
}
