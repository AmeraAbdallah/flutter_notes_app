import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/home/notesList.dart';
import 'package:note_app/services/auth.dart';
import 'package:note_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:note_app/models/user.dart';

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

class Home extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();
       // final user = Provider.of<User>(context);
    // DatabaseService(uid: user.uid);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DatabaseService _db = DatabaseService(uid: user.uid);
    return StreamProvider<QuerySnapshot>.value(
      value: _db.notes,
          child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100), // here the desired height
            child: AppBar(
              backgroundColor: Theme.of(context).accentColor,
              title: Text(
                "Notes",
                style: TextStyle(color: "#16DB93".toColor(), fontSize: 24),
              ),
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
          ),
          body: NotesList(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            child: Icon(Icons.add),
            backgroundColor: "#A4036F".toColor(),
          ),
        ),
    );
  }
}
