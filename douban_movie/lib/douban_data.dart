


/// 豆瓣列表Data Model
class DouBanMovieData {
  String title;
//  double count; // 每页最多数量
//  double total; // 当前页条目数
  List<Movie> movies; // 电影列表

  DouBanMovieData({
    this.title,
//    this.count,
//    this.total,
    this.movies,
  });

  factory DouBanMovieData.fromJson(Map<String, dynamic> json) {
    var list = json['subjects'] as List;
    List<Movie> movieList = list.map((i) => Movie.fromJson(i)).toList();

    return DouBanMovieData(
        title: json['title'],
//        count: json['count'],
//        total: json['total'],
        movies: movieList
    );
  }
}

/// 豆瓣电影Model
class Movie {
  num rating; // 电影评分
  int collectCount; // 收藏数 | 观看人数
  String title; // 电影名
  List<Person> casts; // 演员表
  String originalTitle; // 原始名
  String subtype; // 类型
  String year; // 电影年份
  String image; // 电影海报
  List<String> genres; // 电影类型
  List<Person> directors; // 电影导演表
  String alt; // 电影简介地址
  String id;

  Movie({
    this.rating,
    this.collectCount,
    this.title,
    this.casts,
    this.originalTitle,
    this.subtype,
    this.year,
    this.image,
    this.genres,
    this.directors,
    this.alt,
    this.id
  });

  factory Movie.fromJson(Map<String, dynamic> mJson) {
    var gList = mJson['genres'];
    List<String> genresList = new List<String>.from(gList);

    var cList = mJson['casts'] as List;
    List<Person> castsList = cList.map((i) => Person.fromJson(i)).toList();

    var dList = mJson['directors'] as List;
    List<Person> directorList = dList.map((i) => Person.fromJson(i)).toList();

    num average = mJson['rating']['average'];


    return Movie(
        rating: average,
        collectCount: mJson['collect_count'],
        title: mJson['title'],
        casts: castsList,
        originalTitle: mJson['original_title'],
        subtype: mJson['subtype'],
        year: mJson['year'],
        image: mJson['images']['medium'],
        genres: genresList,
        directors: directorList,
        alt: mJson['alt'],
        id: mJson['id']
    );
  }
}


class Person {
  String alt; // 简介
  String avatar; // 头像
  String name; // 名字
  String id;

  Person({
    this.alt,
    this.avatar,
    this.name,
    this.id,
  });

  factory Person.fromJson(Map<String, dynamic> pJson) {

    var avatar = '';
    if (pJson['avatars'] != null) {
      avatar = pJson['avatars']['medium'];
    }

    return Person(
        alt: pJson['alt'],
        avatar: avatar,
        name: pJson['name'],
        id: pJson['id']
    );
  }
}
