import 'package:flutter/material.dart';
import 'package:note_app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue[900], 
        title: Text('My Notes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            color: Colors.white,
            iconSize: 30,
            onPressed: () async {
              await _auth.logout();
            },
          ),
        ],
      ),
    );
  }
}