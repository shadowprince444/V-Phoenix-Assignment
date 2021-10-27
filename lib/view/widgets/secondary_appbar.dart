import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesofindia/view_models/news_article_vm.dart';

import '../screen_config_constants.dart';

class SecondaryAppBar extends StatelessWidget {
  final Widget action;

  final double gridHeight, gridWidth;
  const SecondaryAppBar(
      {Key? key,
      required this.action,
      required this.gridHeight,
      required this.gridWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenConfig().read(context);

    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(gridHeight * 2),
              bottomRight: Radius.circular(gridHeight * 2))),
      height: gridHeight * 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: gridHeight * 1,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: IconButton(
                    onPressed: () {
                      if (Provider.of<NewsArticleVM>(context, listen: false)
                              .pickedImageFile !=
                          null) {
                        Provider.of<NewsArticleVM>(context, listen: false)
                            .removeImage();
                      }
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                    icon: Icon(
                      Icons.arrow_back,
                      size: gridHeight * 5,
                    )),
              ),
              SizedBox(
                width: gridWidth * 10,
              ),
              Image.asset(
                "assets/times.png",
                fit: BoxFit.fitWidth,
                width: gridWidth * 40,
              ),
              const Expanded(
                child: SizedBox(),
              ),
              action
            ],
          ),
        ],
      ),
    );
  }
}
