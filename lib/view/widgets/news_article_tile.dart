import 'package:flutter/material.dart';
import 'package:timesofindia/models/article_model.dart';
import 'package:timesofindia/view/screens/article_detailed_screen.dart';
import 'package:timesofindia/view/widgets/image_loader.dart';
import 'package:timesofindia/view/screen_config_constants.dart';

class ArticleTile extends StatelessWidget {
  final double gridHeight, gridWidth;
  final Articles articles;
  const ArticleTile(
      {Key? key,
      required this.gridHeight,
      required this.gridWidth,
      required this.articles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleDetailedScreen(
                      article: articles,
                      gridHeight: gridHeight,
                      gridWidth: gridWidth,
                    )));
      },
      child: SizedBox(
        width: gridWidth * 100,
        child: Padding(
          padding: EdgeInsets.all(gridHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: gridWidth * 35,
                    child: Center(
                      child: SizedBox(
                        width: gridWidth * 30,
                        height: gridHeight * 10,
                        child: NetworkImageLoader(
                          boxFit: BoxFit.fitHeight,
                          path: articles.urlToImage ?? "",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: Text(
                          articles.title ?? "",
                          style: ScreenConfig.blackH6Bold,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      SizedBox(
                        child: Text(articles.description ?? ""),
                      )
                    ],
                  ))
                ],
              ),
              Container(
                width: gridWidth * 98,
                color: Colors.grey.withOpacity(.5),
                height: gridHeight * .1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
