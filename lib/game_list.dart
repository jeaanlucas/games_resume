import 'package:flutter/material.dart';
import 'package:games_resume/game_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GameList extends StatefulWidget {
  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {

  List<dynamic> _listaGames = List();
  String _nextPage;
  String _previousPage;

  @override
  void initState() {
    super.initState();

    _carregarListGames();
  }

  void _carregarListGames() async {
    _makeRequest('https://api.rawg.io/api/games?page_size=30');
  }

  void _next() async {
    if (_nextPage == null) {
      return;
    }

    _makeRequest(_nextPage);
  }

  void _previous() async {
    if (_previousPage == null) {
      return;
    }

    _makeRequest(_previousPage);
  }

  void _makeRequest(String url) async {
    _listaGames.clear();

    final response = await http.get(url);
    final json = convert.jsonDecode(response.body);
    setState(() {
      _nextPage = json['next'];
      _previousPage = json['previous'];
      _listaGames = json['results'];
    });
  }

  Future<List<dynamic>> _getListGames() async {
    return _listaGames;
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.4),
        title: Center(
          child: Text(
            'Games Radar',
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _getListGames(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.blue,
                      ),
                      onPressed: () => _previous(),
                    ),
                  ),
                  Container(
                    child: Text(
                      'NAVEGAÇÃO',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                      ),
                      onPressed: () => _next(),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: _listaGames.length,
                  itemBuilder: (BuildContext context, int index) {
                    final objeto = _listaGames[index];

                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Game: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23.0,
                                ),
                              ),
                              Text(
                                capitalize(objeto['name']),
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Score: ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                              Text(
                                '${objeto['rating'].toString()} / 5',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                            ],
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameDetails(
                                id: objeto['id'],
                                title: objeto['name'],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
