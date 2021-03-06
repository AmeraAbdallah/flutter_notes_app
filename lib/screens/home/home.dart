import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/home/notesList.dart';
import 'package:note_app/services/auth.dart';
import 'package:note_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:note_app/models/user.dart';

//extension ColorExtension on String {
//  toColor() {
//    var hexColor = this.replaceAll("#", "");
//    if (hexColor.length == 6) {
//      hexColor = "FF" + hexColor;
//    }
//    if (hexColor.length == 8) {
//      return Color(int.parse("0x$hexColor"));
//    }
//  }
//}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DatabaseService _db = DatabaseService(uid: user.uid);

    String title = '';
    String description = '';

    setTitle(val) {
      setState(() {
        title = val;
      });
    }

    setDescription(val) {
      setState(() {
        description = val;
      });
    }

    dynamic addNot() async {
      await _db.addToNotes(title, description);
    }

    return StreamProvider<QuerySnapshot>.value(
      value: _db.notes,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100), // here the desired height
          child: AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: Text(
              "Notes",
              style: TextStyle(color: Color(0x16DB93), fontSize: 24),
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
            _settingModalBottomSheet(context, (val) => setTitle(val),  (val) => setDescription(val), addNot);
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xFFA4036F),
        ),
      ),
    );
  }
}

void _settingModalBottomSheet(context, setTitle, setDescription, addNote) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              Container(
                  color: Color(0x16DB93),
                  width: double.infinity,
                  // height: 45,
                  padding: new EdgeInsets.fromLTRB(10, 30, 10, 30),
                  child: Text(
                    'Add new Note :)',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )),
              Container(
                  padding: new EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                    onChanged: (val){
                      setTitle(val);
                    },
                  )),
              Container(
                  padding: new EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                    onChanged: (val) {
                      setDescription(val);
                    },
                  )),
              Container(
                padding: new EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: new EdgeInsets.all(10),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        color: Color(0x707070),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: OutlineButton(
                        padding: new EdgeInsets.all(10),
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Color(0xA4036F), fontSize: 24),
                        ),
                        borderSide:
                            BorderSide(color: Color(0xA4036F), width: 2),
                        onPressed: () async {
                          await addNote();
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      });
}
