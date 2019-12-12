import 'package:flutter/material.dart';
import 'package:games_resume/home_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _revelarSenha = true;

  void _exibeSenha() {
    setState(() => _revelarSenha = !_revelarSenha);
  }

  void _efetuarLogin() {
    if (_formKey.currentState.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final heigth = size.height;

    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            width: width * 0.9,
            height: heigth * 0.35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(
                    0.0,
                    15.0,
                  ),
                  blurRadius: 15.0,
                ),
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(
                    0.0,
                    -10.0,
                  ),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Games Radar',
                    style: TextStyle(
                      fontSize: 45.0,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Usuário',
                    style: TextStyle(
                      fontSize: 26.0,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Usuário',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                    validator: (value) => value.isEmpty ? 'Usuário obrigatório!' : null,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Senha',
                    style: TextStyle(
                      fontSize: 26.0,
                    ),
                  ),
                  TextFormField(
                    obscureText: _revelarSenha,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _revelarSenha ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: _exibeSenha,
                      ),
                    ),
                    validator: (value) => value.isEmpty ? 'Senha obrigatória!' : null,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: width * 0.2,
                    height: heigth * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(
                            0.0,
                            8.0,
                          ),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 15.0,
                            ),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        onTap: _efetuarLogin,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
