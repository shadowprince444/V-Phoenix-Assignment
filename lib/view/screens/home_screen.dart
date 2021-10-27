import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesofindia/repository/news_article_repo.dart';
import 'package:timesofindia/view_models/news_article_vm.dart';

import '../widgets/news_article_tile.dart';
import '../screen_config_constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double? gridHeight, gridWidth;
  @override
  void initState() {
    NewsArticleRepo().fetchRepo(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().read(context);
    gridHeight = ScreenConfig.gridHeight;
    gridWidth = ScreenConfig.gridWidth;
    //

    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: gridHeight! * 100,
            width: gridWidth! * 100,
            color: Colors.white,
            child: Column(
              children: [
                appBarWidget(),
                Expanded(
                    child: TabBarView(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Center(
                          child: Text(
                        "Home Screen",
                        style: ScreenConfig.blackH1,
                      )),
                    ),
                    newsListBuilder(context),
                    Container(
                      color: Colors.white,
                      child: Center(
                          child: Text(
                        "Most Shared Screen",
                        style: ScreenConfig.blackH1,
                      )),
                    ),
                    Container(
                      color: Colors.white,
                      child: Center(
                          child: Text(
                        "Most Read Screen",
                        style: ScreenConfig.blackH1,
                      )),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container appBarWidget() {
    return Container(
      color: ScreenConfig.appBar,
      height: gridHeight! * 12,
      width: gridWidth! * 100,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              //height: gridHeight! * ,
              width: gridWidth! * 100,
              child: Center(
                  child: Image.asset(
                "assets/times.png",
                fit: BoxFit.fitWidth,
                width: gridWidth! * 60,
              )),
            ),
          ),
          TabBar(
            tabs: [
              Icon(
                Icons.home,
                size: gridHeight! * 3,
              ),
              const Text(
                "Latest News",
              ),
              const Text(
                "Most Shared",
              ),
              const Text(
                "Most Read",
              )
            ],
            indicator: const BoxDecoration(color: Colors.white),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: ScreenConfig.blackH6Bold, labelColor: Colors.black,
            labelPadding: EdgeInsets.symmetric(
                vertical: gridHeight! * .5, horizontal: gridWidth!),
            // isScrollable: true,
            unselectedLabelStyle: ScreenConfig.whiteH6,
            unselectedLabelColor: Colors.white,
          )
        ],
      ),
    );
  }

  SizedBox newsListBuilder(BuildContext context) {
    return SizedBox(
      height: gridHeight! * 88,
      width: gridWidth! * 100,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(gridHeight! * 2),
              child: RichText(
                  text: TextSpan(
                      text: "News ",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: gridHeight! * 1.5,
                          fontWeight: FontWeight.w600),
                      children: [
                    TextSpan(
                        text: " >> Latest News", style: ScreenConfig.blackH6)
                  ])),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: gridHeight!, horizontal: gridWidth!),
              child: Text(
                "LATEST NEWS",
                style: ScreenConfig.blackH1,
              ),
            ),
            Container(
              color: Colors.black,
              height: gridHeight! * .25,
              width: gridWidth! * 100,
            ),
            Consumer<NewsArticleVM>(builder: (context, newArticleVm, _) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ArticleTile(
                    articles: newArticleVm.newsArticle!.articles[index],
                    gridHeight: gridHeight!,
                    gridWidth: gridWidth!,
                  );
                  // Container(
                  //   color: Colors.black,
                  //   height: gridHeight! * 5,
                  //   padding: EdgeInsets.only(bottom: gridHeight!),
                  //   child: Text(index.toString()),
                  // );
                },
                itemCount: newArticleVm.newsArticle?.articles.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              );
            })
          ],
        ),
      ),
    );
  }
}
