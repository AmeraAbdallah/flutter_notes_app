import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/services/auth.dart';
import 'package:note_app/style.dart';

class NoteDetails extends StatelessWidget {
  Note note;
  NoteDetails({this.note});
  final AuthenticationService _auth = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.grey,
        actions: <Widget>[
              FlatButton(
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                onPressed: () async {
                  await _auth.logout();
                },
              )
        ],
      ),
      body: Column(children: <Widget>[
        Container(
            width: double.infinity,
            height: 175,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
            color: Style.yellow,
            child: Text(
            note.title,
            style: TextStyle(
              color: Style.textColor,
              fontSize: 24
            ),
          ),
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
            child: Text(
              note.description,
              style: TextStyle(
                color: Style.textColor,
                fontSize: 20
              ),
            ),
          )
      ],)
    );
  }
}