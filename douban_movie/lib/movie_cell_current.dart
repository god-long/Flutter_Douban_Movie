import 'package:flutter/material.dart';
import 'douban_data.dart';

class CurrentMovieCell extends StatelessWidget {
  final Movie movie;
  CurrentMovieCell(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
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
          Container(
            child: CurrentMovieMiddle(movie),
          ),
          Container(
            width: .5,
            height: 80.0,
            color: Colors.grey[400],
          ),
          Expanded(
            flex: 1,
            child: CurrentMovieRight(movie),
          )
        ],
      ),
    );
  }
}

class CurrentMovieMiddle extends StatelessWidget {

  final Movie movie;

  CurrentMovieMiddle(this.movie);

  @override
  Widget build(BuildContext context) {

    List directorNames = movie.directors.map((director) => director.name).toList();

    List castsNames = movie.casts.map((cast) => cast.name).toList();

    var desc = movie.year + ' / ' + movie.genres.join(' ') + ' / '
        + directorNames.join(' ') + ' / ' + castsNames.join(' ');

    return new Container(
      width: 180.0,
      padding: const EdgeInsets.only(right: 10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30.0,
            padding: const EdgeInsets.only(left: 10.0, top: 0.0),
            child: Text(
              movie.title,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Container(
            height: 20.0,
            padding: const EdgeInsets.only(left: 10.0, top: 0.0),
            child: Text(
              movie.rating.toString(),
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[700]),
            ),
          ),
          Container(
            height: 50.0,
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              desc,
              style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}


class CurrentMovieRight extends StatelessWidget {

  final Movie movie;

  CurrentMovieRight(this.movie);

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