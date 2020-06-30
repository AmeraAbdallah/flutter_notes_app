import 'package:flutter/material.dart';
import 'package:note_app/services/auth.dart';
import 'package:loading/loading.dart';
import 'package:note_app/style.dart';

class SignIn extends StatefulWidget {
  final Function toggleIsSignInView;
  SignIn({this.toggleIsSignInView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                    color: Style.green,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Note",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Style.lightGrey, width: 2),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Style.pink),
                          filled: true,
                          hintStyle: new TextStyle(
                            color: Style.lightGrey,
                            fontSize: 18,
                          ),
                          hintText: "Johndoe@gmail.com",
                          fillColor: Colors.white,
                          errorText:
                              _emailValidate ? 'Email Can\'t Be Empty' : null,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
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
                            borderSide:
                                BorderSide(color: Style.lightGrey, width: 2),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Style.pink),
                          filled: true,
                          hintStyle: new TextStyle(
                            color: Style.lightGrey,
                            fontSize: 18,
                          ),
                          hintText: "*******",
                          fillColor: Colors.white,
                          errorText: _passwordValidate
                              ? 'Password length Can\'t Be less than 6.'
                              : null,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                          ),
                        ),
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
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
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                              color: Style.grey,
                              onPressed: () async {
                                if (email.length == 0) {
                                  setState(() => _emailValidate = true);
                                }
                                if (password.length < 6) {
                                  setState(() => _passwordValidate = true);
                                }
                                if (email.length != 0 && password.length >= 6) {
                                  setState(() {
                                    _passwordValidate = false;
                                    _emailValidate = false;
                                    _isLoading = true;
                                  });
                                  dynamic result = await _auth
                                      .signInUserUsingEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error = "Wrong Email or Password";
                                      _isLoading = false;
                                    });
                                  }
                                }
                              })),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'Do not have an account?',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                            ),
                          ),
                          FlatButton(
                            textColor: Colors.black54,
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline
                                ),
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
                )
              ],
            )));
  }
}
