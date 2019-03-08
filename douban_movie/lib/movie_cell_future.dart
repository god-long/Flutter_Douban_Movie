import 'package:flutter/material.dart';
import 'douban_data.dart';

class FutureMovieCell extends StatelessWidget {
  final Movie movie;
  FutureMovieCell(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 10.0),
      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
      decoration: new BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey[300])),
      ),
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
            child: FutureMovieMiddle(movie),
          ),
          Container(
            width: .5,
            height: 80.0,
            color: Colors.grey[400],
          ),
          Expanded(
            flex: 1,
            child: FutureMovieRight(movie),
          )
        ],
      ),
    );
  }
}

class FutureMovieMiddle extends StatelessWidget {

  final Movie movie;

  FutureMovieMiddle(this.movie);

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


class FutureMovieRight extends StatelessWidget {

  final Movie movie;

  FutureMovieRight(this.movie);

  @override
  Widget build(BuildContext context) {

    var collect = movie.collectCount / 10000;
    String collectStr = collect.toStringAsFixed(1);

    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: 25.0,
          child: new FlatButton(
            child: new Image(image: AssetImage('images/love.png'), width: 20.0, height: 20.0,),
            onPressed: () {

            },
          ),
        ),
        new Container(
          height: 15.0,
          child: new Text('想看', style: TextStyle(color: Colors.orangeAccent, fontSize: 13.0),),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: new Text(
            '$collectStr万人想看',
            style: TextStyle(color: Colors.grey[500], fontSize: 10.0),
          ),
        )
      ],
    );
  }
}