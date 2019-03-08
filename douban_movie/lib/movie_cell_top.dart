import 'package:flutter/material.dart';
import 'douban_data.dart';

class TopMovieCell extends StatelessWidget {
  final Movie movie;
  TopMovieCell(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 142.0,
      margin: const EdgeInsets.only(left: 15.0, top: 0.0, bottom: 0.0, right: 15.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Image.network(
              movie.image,
              width: 85.0,
              height: 120.0,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 1,
            child: TopMovieMiddle(movie),
          ),
        ],
      ),
    );
  }
}

class TopMovieMiddle extends StatelessWidget {

  final Movie movie;

  TopMovieMiddle(this.movie);

  @override
  Widget build(BuildContext context) {

    List directorNames = movie.directors.map((director) => director.name).toList();

    List castsNames = movie.casts.map((cast) => cast.name).toList();

    var desc = movie.year + ' / ' + movie.genres.join(' ') + ' / '
        + directorNames.join(' ') + ' / ' + castsNames.join(' ');

    var collect = movie.collectCount / 10000;
    var collectStr = collect.toStringAsFixed(1);

    return new Container(
      padding: const EdgeInsets.only(right: 10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30.0,
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: Text(
              movie.title,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Container(
            height: 25.0,
            padding: const EdgeInsets.only(left: 10.0, top: 8.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '电影评分   ',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[600]),
                ),
                Text(
                  movie.rating.toString(),
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.orange),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 0),
            child: Text(
              desc,
              style: TextStyle(fontSize: 12.0, color: Colors.grey[400]),
            ),
          ),
          Container(
            height: 20.0,
            margin: const EdgeInsets.only(left: 10.0, top: 8),
            child: Text(
              '$collectStr万人看过',
              style: TextStyle(fontSize: 12.0, color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }
}


class TopMovieRight extends StatelessWidget {

  final Movie movie;

  TopMovieRight(this.movie);

  @override
  Widget build(BuildContext context) {

    var collect = movie.collectCount / 10000;
    String collectStr = collect.toStringAsFixed(1);

    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 60.0,
            height: 30.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent, width: 1.0),
                borderRadius: BorderRadius.circular(2.0)),
            child: new InkWell(
                onTap: () {
                  Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Go to buy ${movie.title}')));
                },
                child: new Center(
                  child: Text(
                    '购票',
                    style:
                    TextStyle(color: Colors.redAccent, fontSize: 15.0),
                  ),
                ))),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: new Text(
            '$collectStr万人看过',
            style: TextStyle(color: Colors.grey[500], fontSize: 12.0),
          ),
        )
      ],
    );
  }
}