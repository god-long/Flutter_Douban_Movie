import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dart:convert';
import 'douban_data.dart';
import 'movie_cell_current.dart';
import 'movie_cell_future.dart';
import 'movie_cell_top.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'webview_detail.dart';

/// 正在热映Widget
class CurrentMovie extends StatefulWidget {
  @override
  CurrentMovieState createState() => new CurrentMovieState();
}

class CurrentMovieState extends State<CurrentMovie> with AutomaticKeepAliveClientMixin<CurrentMovie> {

  // 属性
  List<Movie> movies = new List();

  @override
  bool get wantKeepAlive => true;

  // 生命周期
  @override
  void initState() {
    super.initState();
    getDouBanCurrentMovie();
    print('初始化');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('热映'),
      ),
      body: movies.length <= 0 ? new SpinKitDoubleBounce(color: Colors.orange,) :
      LiquidPullToRefresh(
        onRefresh: getDouBanCurrentMovie,
        showChildOpacityTransition: false,
        child: new ListView.builder(
          itemBuilder: (context, i) {
            return InkWell(
              onTap: (){
                gotoWebDetail(context, movies[i].alt);
              },
              child: CurrentMovieCell(movies[i]),
            );
          },
          itemCount: movies.length,
        ),
      ),
    );
  }

  void gotoWebDetail(BuildContext context, String url) {
    print(url);
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new WebViewDetail(urlString: "https://www.baidu.com",);
//          return new WebViewDemoPage(urlString: url,);
        }
      )
    );
  }

  // 网络请求
  Future getDouBanCurrentMovie() async {
    try {
      Response response = await Dio()
          .get("https://api.douban.com/v2/movie/in_theaters?count=20");
      print(response.statusCode);
      final jsonResponse = json.decode(response.toString());
      print(jsonResponse);
      DouBanMovieData tempDoubanModel = new DouBanMovieData.fromJson(jsonResponse);
      print(tempDoubanModel.movies[0].image);

      setState(() {
        movies = tempDoubanModel.movies;
      });
    }catch (e) {
      print(e);
    }
  }


}




/// 即将上映Widget
class FutureMovie extends StatefulWidget {
  @override
  FutureMovieState createState() => new FutureMovieState();
}

class FutureMovieState extends State<FutureMovie> with AutomaticKeepAliveClientMixin {

  List<Movie> futureMovies = new List();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getDouBanFutureMovie();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('即将上映'),
      ),
      body: futureMovies.length <= 0 ? new SpinKitDoubleBounce(color: Colors.orange,) :
      LiquidPullToRefresh(
        onRefresh: getDouBanFutureMovie,
        height: 80,
        showChildOpacityTransition: true,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return FutureMovieCell(futureMovies[index]);
          },
          itemCount: futureMovies.length,
        ),
      )
    );
  }
  
  
  // 网络请求
  Future getDouBanFutureMovie() async {
    try {
      Response response = await Dio().get("https://api.douban.com/v2/movie/coming_soon?start=0&count=20");
      print(response.statusCode);
      final jsonResponse = json.decode(response.toString());
      print('即将上映');
      print(jsonResponse);
      DouBanMovieData tempDoubanModel =
      new DouBanMovieData.fromJson(jsonResponse);
      print(tempDoubanModel.movies[0].image);

      setState(() {
        futureMovies = tempDoubanModel.movies;
      });
    } catch (e) {
      print(e);
    }
  }
  
}




/// Top电影Widget
class TopMovie extends StatefulWidget {
  @override
  TopMovieState createState() => new TopMovieState();
}

class TopMovieState extends State<TopMovie> with AutomaticKeepAliveClientMixin {

  List<Movie> topMovies = List();
  final scrollController = ScrollController();
  bool isLoading = false;
  bool isNoMore = false;
  int pageIndex = 0;
  int pageCount = 10;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getDouBanTopMovie();

    scrollController.addListener(() {
      if (scrollController.offset == scrollController.position.maxScrollExtent) {
        if (!isNoMore) {
          loadMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Top250'),
      ),
      body: topMovies.length <=0 ? new SpinKitDoubleBounce(color: Colors.blueGrey,) :
      LiquidPullToRefresh(
        scrollController: scrollController,
        onRefresh: getDouBanTopMovie,
        showChildOpacityTransition: false,
        child: new ListView.separated(
          itemBuilder: (context, index) {
            if (index == topMovies.length) {
              return Container(
                height: 40.0,
                child: Center(
                  child: isLoading ? CircularProgressIndicator(strokeWidth: 1.0,) : Text(isNoMore ? '已经拉到低了' : '上拉加载更多'),
                ),
              );
            }else {
              return TopMovieCell(topMovies[index]);
            }
          },
          separatorBuilder: (context, index) {
            return Divider(indent: 15.0,);
          },
          itemCount: topMovies.length + 1,
        ),
      ),
    );
  }

  // 网络请求
  Future getDouBanTopMovie() async {
    try {
      Response response = await Dio().get("https://api.douban.com/v2/movie/top250?start=0&count=$pageCount");
      print(response.statusCode);
      final jsonResponse = json.decode(response.toString());
      print('即将上映');
      print(jsonResponse);
      DouBanMovieData tempDoubanModel =
      new DouBanMovieData.fromJson(jsonResponse);
      print(tempDoubanModel.movies[0].image);

      setState(() {
        if (tempDoubanModel.movies.length < pageCount) {
          isNoMore = true;
        }else {
          isNoMore = false;
        }
        pageIndex = 1;
        topMovies = tempDoubanModel.movies;
      });
    } catch (e) {
      print(e);
    }
  }


  // 加载更多
  Future loadMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      int start = pageIndex * pageCount;
      Response response = await Dio()
          .get("https://api.douban.com/v2/movie/top250?start=$start&count=$pageCount");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.toString());
        print(jsonResponse);
        DouBanMovieData tempDoubanModel =
        new DouBanMovieData.fromJson(jsonResponse);
        print(tempDoubanModel.movies[0].image);

        await Future.delayed(Duration(seconds: 2), (){
          setState(() {
            if (tempDoubanModel.movies.length < pageCount) {
              isNoMore = true;
            }
            pageIndex = pageIndex + 1;
            isLoading = false;
            topMovies.addAll(tempDoubanModel.movies);
          });
        });
      }
    }
  }
}