import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Dlc extends StatelessWidget {
  final int id;

  Dlc({
    this.id,
  });

  List<dynamic> _listaDlc = List();

  Future<List<dynamic>> _carregarDlc() async {
    final response = await http.get('https://api.rawg.io/api/games/${this.id}/additions');
    final json = convert.jsonDecode(response.body);
    _listaDlc = json['results'];

    return _listaDlc;
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
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
            'DLC\'s',
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _carregarDlc(),
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

          return ListView.builder(
            itemCount: _listaDlc.length,
            itemBuilder: (BuildContext context, int index) {
              final objeto = _listaDlc[index];

              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'DLC: ',
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
              );
            },
          );
        },
      ),
    );
  }
}
