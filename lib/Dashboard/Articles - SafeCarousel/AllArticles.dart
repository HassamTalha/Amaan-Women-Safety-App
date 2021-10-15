import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:womensafteyhackfair/Dashboard/Articles%20-%20SafeCarousel/ArticleDesc.dart';
import 'package:womensafteyhackfair/Dashboard/Articles%20-%20SafeCarousel/SadeWebView.dart';
import 'package:womensafteyhackfair/constants.dart';

class AllArticles extends StatefulWidget {
  AllArticles({Key key}) : super(key: key);

  @override
  _AllArticlesState createState() => _AllArticlesState();
}

class _AllArticlesState extends State<AllArticles>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(fit: StackFit.expand, children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/bg-top.png',
                ),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
              color: Colors.grey[50].withOpacity(0.3),
            ),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 188.0,
                  backgroundColor: Colors.grey[50].withOpacity(0.3),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Lottie.asset(
                      "assets/reading.json",
                      controller: _controller,
                      onLoaded: (composition) {
                        _controller
                          ..duration = composition.duration
                          ..forward();
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    List.generate(
                      imageSliders.length,
                      (index) => Hero(
                        tag: articleTitle[index],
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            height: 180,
                            child: InkWell(
                              onTap: () {
                                // WebviewScaffold(
                                //   url: "https://www.google.com",
                                //   appBar: new AppBar(
                                //     title: new Text("Widget webview"),
                                //   ),
                                // ),
                                if (index == 0) {
                                  navigateToRoute(
                                      context,
                                      SafeWebView(
                                          index: index,
                                          title:
                                              "Pakistani women inspiring the country",
                                          url:
                                              "https://gulfnews.com/world/asia/pakistan/womens-day-10-pakistani-women-inspiring-the-country-1.77696239"));
                                } else if (index == 1) {
                                  navigateToRoute(
                                      context,
                                      SafeWebView(
                                          index: index,
                                          title: "We have to end Violance",
                                          url:
                                              "https://plan-international.org/ending-violence/16-ways-end-violence-girls"));
                                } else if (index == 2) {
                                  navigateToRoute(
                                      context, ArticleDesc(index: index));
                                } else {
                                  navigateToRoute(
                                      context,
                                      SafeWebView(
                                          index: index,
                                          title: "You are strong",
                                          url:
                                              "https://www.healthline.com/health/womens-health/self-defense-tips-escape"));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(imageSliders[index]),
                                      fit: BoxFit.cover),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.5),
                                            Colors.transparent
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight)),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, bottom: 8),
                                      child: Text(
                                        articleTitle[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void navigateToRoute(
    BuildContext context,
    Widget route,
  ) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => route,
      ),
    );
  }
}
