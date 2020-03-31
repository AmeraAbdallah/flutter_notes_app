import 'package:flutter/material.dart';
import 'package:note_app/services/auth.dart';
import 'package:loading/loading.dart';

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
      return _isLoading? Loading():
      Scaffold(
        backgroundColor: Colors.blue[900],
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50,),
              new TextField(
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                    ),
                    hintText: "Type in your Email",
                    fillColor: Colors.deepPurple[50],
                    errorText:  _emailValidate ? 'Email Can\'t Be Empty.' : null,
                  ),
                  onChanged: (val) {
                    setState(() => email = val);
                  },
              ),
              SizedBox(height: 20,),
              new TextField(
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                    ),
                    hintText: "Type in your Password",
                    fillColor: Colors.deepPurple[50],
                    errorText: _passwordValidate ? 'Password length Can\'t Be less than 6.' : null,
                ),
                obscureText: true,
                onChanged: (val) {
                    setState(() => password = val);
                  },
              ),
              SizedBox(height: 20,),
              ButtonTheme(
                minWidth: 180,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    "Login", 
                    style: 
                    TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      ),
                    ), 
                    color: Colors.amber[900], 
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      // side: BorderSide(color: Colors.red),
                    ),
                    onPressed: () async {
                        if(email.length == 0) {
                          setState(() => _emailValidate = true);
                        }
                        if(password.length < 6) {
                          setState(() => _passwordValidate = true);
                        }
                        if(email.length != 0 && password.length >= 6) {
                          setState((){
                            _passwordValidate = false;
                            _emailValidate = false;
                            _isLoading = true;
                          });
                          dynamic result = await _auth.signInUserUsingEmailAndPassword(email, password);
                          if(result == null) {
                            setState(() {
                              error = "Wrong Email or Password";
                              _isLoading = false;
                            });
                          }
                        }
                    }
                  )
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Do not have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        widget.toggleIsSignInView();
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(height: 20,),
                Text(
                  error,
                  style: TextStyle(color: Colors.red),
                )
            ],
          )
        )
      );
  }
}
