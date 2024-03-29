import 'package:flutter/material.dart';
import 'package:games_resume/dlc.dart';
import 'package:games_resume/game_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GameDetails extends StatefulWidget {
  final String title;
  final int id;

  GameDetails({
    this.id,
    this.title,
  });

  @override
  _GameDetailsState createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {
  GameModel _game = GameModel();

  @override
  void initState() {
    super.initState();

    _carregarInfoGame();
  }

  Future<GameModel> _carregarInfoGame() async {
    final response = await http.get('https://api.rawg.io/api/games/${widget.id}');
    final json = convert.jsonDecode(response.body);
    _game = GameModel.fromJson(json);

    return _game;
  }

  void _showDlcs() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dlc(
          id: widget.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final heigth = size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.grey.withOpacity(0.4),
        title: Center(
          child: Text(
            this.widget.title,
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _carregarInfoGame(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: <Widget>[
              Container(
                width: width * 1,
                height: heigth * 0.70,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      _game.backgroundImage,
                    ),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Release date: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 28.0,
                            ),
                          ),
                          Text(
                            _game.released,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Score: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 28.0,
                            ),
                          ),
                          Text(
                            _game.rating.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            ' / 5',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      width: width * 0.11,
                      height: heigth * 0.025,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: Center(
                            child: Text(
                              'DLC\'S',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          onTap: _showDlcs,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'DESCRIPTION',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.red,
                  ),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      _game.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
