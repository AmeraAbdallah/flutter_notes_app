import 'package:flutter/material.dart';
import 'package:note_app/services/auth.dart';
import 'package:loading/loading.dart';

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class Register extends StatefulWidget {
  final Function toggleIsSignInView;
  Register({this.toggleIsSignInView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String password = '';
  bool _emailValidate = false;
  bool _passwordValidate = false;
  String error = '';
  bool _isLoading = false;
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                child: Column(
              children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  // padding: Padding.,
                  color: "#16DB93".toColor(),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Note",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40
                      ),
                      ),
                  ),
                  // child: Text("Note"),
                ),
              ),
                new Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    // child: Align(
                    //   alignment: Alignment.bottomCenter,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: "#707070".toColor(), width: 2),
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: "#A4036F".toColor()),
                              filled: true,
                              hintStyle: new TextStyle(
                                color: '#707070'.toColor(),
                                fontSize: 18,
                              ),
                              hintText: "Johndoe@gmail.com",
                              fillColor: Colors.white,
                              errorText: _emailValidate
                                  ? 'Email Can\'t Be Empty'
                                  : null,
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                              ),
                            ),
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          new TextField(
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: "#707070".toColor(), width: 2),
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: "#A4036F".toColor()),
                              filled: true,
                              hintStyle: new TextStyle(
                                color: '#707070'.toColor(),
                                fontSize: 18,
                              ),
                              hintText: "*******",
                              fillColor: Colors.white,
                              errorText: _passwordValidate
                                  ? 'Password length Can\'t Be less than 6.'
                                  : null,
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                              ),
                            ),
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonTheme(
                              minWidth: double.infinity,
                              height: 50,
                              child: RaisedButton(
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                  color: "#8C86AA".toColor(),
                                  onPressed: () async {
                                    if (email.length == 0) {
                                      setState(() => _emailValidate = true);
                                    }
                                    if (password.length < 6) {
                                      setState(() => _passwordValidate = true);
                                    }
                                    if (email.length != 0 &&
                                        password.length >= 6) {
                                      setState(() {
                                        _passwordValidate = false;
                                        _emailValidate = false;
                                        _isLoading = true;
                                      });

                                      dynamic result = await _auth
                                          .createUserUsingEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          error = "Not valid Email";
                                          _isLoading = false;
                                        });
                                      }
                                    }
                                  })),
                          Row(
                            children: <Widget>[
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                    color: "#707070".toColor(), fontSize: 18),
                              ),
                              FlatButton(
                                textColor: "#707070".toColor(),
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.underline),
                                ),
                                onPressed: () {
                                  widget.toggleIsSignInView();
                                },
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    // )
                  ),
              ],
            )));
  }
}
