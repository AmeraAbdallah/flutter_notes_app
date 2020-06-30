import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/screens/NoteDetails.dart';

//extension ColorExtension on String {
//  toColorr() {
//    var hexColor = this.replaceAll("#", "");
//    if (hexColor.length == 6) {
//      hexColor = "FF" + hexColor;
//    }
//    if (hexColor.length == 8) {
//      return Color(int.parse("0x$hexColor"));
//    }
//  }
//}

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    final List<Note> entries = <Note>[];
    final List<Color> colorCodes = <Color>[
      Color(0xFFEFEA5A),
      Color(0xFF6DC1A2),
      Color(0xFFBFC0C0),
      Color(0xF0B67F),
      Color(0xFFD6CFCB),
      Color(0xFFC7EFCF)
    ];
    final notes = Provider.of<QuerySnapshot>(context);
    for (var doc in notes.documents) {
      entries.add(Note(title: doc.data['title'], description: doc.data['description']));
    }

    int getColorIndex(int index) {
      if (index > colorCodes.length-1) {
        return new Random().nextInt(colorCodes.length);
      }
      return index;
    }

    return ListView.separated(
      padding: const EdgeInsets.all(50),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoteDetails(note: entries[index])),
                );
              },
              child: Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 20, 10),
              height: 150,
              color: colorCodes[getColorIndex(index)],
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${entries[index].title}',
                      style: TextStyle(color: Color(0xFF172A3A), fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${entries[index].description}',
                      style: TextStyle(
                        color: Color(0xFF172A3A),
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    )
                  ])),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}