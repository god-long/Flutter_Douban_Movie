import 'package:flutter/material.dart';
import 'controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = false; //关闭视觉调试开关
//  debugPaintSizeEnabled = true;      //打开视觉调试开关
  runApp(DoubanMovieApp());
}

class DoubanMovieApp extends StatefulWidget {
  @override
  DoubanMovieAppState createState() => new DoubanMovieAppState();
}

class DoubanMovieAppState extends State<DoubanMovieApp>
    with SingleTickerProviderStateMixin {
  List<Widget> controllers = new List();
  int currentIndex = 0;
  PageController controller;
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
    controllers = [CurrentMovie(), FutureMovie(), TopMovie()];
    controller = PageController(initialPage: 0);
    tabController = TabController(length: controllers.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        // PageView + BottomNavigationBar方式
        body: PageView.builder(
          itemBuilder: (context, index) => controllers[index],
          itemCount: controllers.length,
          controller: controller,
          onPageChanged: pageChange,
          physics: NeverScrollableScrollPhysics(),
        ),
          // TabBarView + BottomNavigationBar方式
//          body: TabBarView(
//            children: controllers,
//            controller: tabController,
//            physics: NeverScrollableScrollPhysics(),
//          ),
          // 如果想使用iOS风格 CupertinoTabBar
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                title: Text('最新上映'),
                icon: Icon(Icons.movie),
              ),
              BottomNavigationBarItem(
                title: Text('即将上映'),
                icon: Icon(Icons.movie),
              ),
              BottomNavigationBarItem(
                title: Text('Top'),
                icon: Icon(Icons.movie),
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    tabController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    controller.jumpToPage(index);
//    setState(() {
//      currentIndex = index;
//    });
//    tabController.animateTo(index, duration: Duration(milliseconds: 500),);
  }

  void pageChange(int index) {
    setState(() {
      if (index != currentIndex) {
        currentIndex = index;
      }
    });
  }
}
