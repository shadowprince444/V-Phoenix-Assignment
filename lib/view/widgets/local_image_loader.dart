import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesofindia/view_models/news_article_vm.dart';

class LocalImageLoader extends StatelessWidget {
  final double gridHeight, gridWidth;
  final File file;
  const LocalImageLoader(
      {Key? key,
      required this.gridHeight,
      required this.gridWidth,
      required this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(gridHeight * .5),
          height: gridHeight * 30,
          width: gridWidth * 100,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.1),
                spreadRadius: gridHeight * .2,
                blurRadius: gridHeight * .2)
          ]),
          child: Center(
            child: Image.file(
              file,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Positioned(
            right: 0,
            top: 0,
            child: IconButton(
                onPressed: () {
                  Provider.of<NewsArticleVM>(context, listen: false)
                      .removeImage();
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: gridHeight * 5,
                )))
      ],
    );
  }
}
