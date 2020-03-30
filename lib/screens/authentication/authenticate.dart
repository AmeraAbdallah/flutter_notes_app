import 'package:flutter/material.dart';
import 'package:note_app/screens/authentication/register.dart';
import 'package:note_app/screens/authentication/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool isSignInView = true;

  void toggleIsSignInView () {
    setState(() => isSignInView = !isSignInView);
  }

  @override
  Widget build(BuildContext context) {
    return (isSignInView) ?  SignIn(toggleIsSignInView: toggleIsSignInView) : Register(toggleIsSignInView: toggleIsSignInView);
  }
}