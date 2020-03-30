import 'package:flutter/material.dart';
import 'package:note_app/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleIsSignInView;
  SignIn({this.toggleIsSignInView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  String email = '';
  String password = '';
  
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    fillColor: Colors.deepPurple[50]
                  ),
                  onChanged: (val) {

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
                ),
                obscureText: true,
                onChanged: (val) {

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
                    onPressed: () {}
                  )
                ),
                Row(
                  children: <Widget>[
                    Text('Do not have an account?'),
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
                )
            ],
          )
        )
      );
  }
}
