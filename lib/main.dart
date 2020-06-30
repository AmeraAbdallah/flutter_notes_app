import 'package:flutter/material.dart';
import 'package:note_app/models/user.dart';
import 'package:note_app/screens/wrapper.dart';
import 'package:note_app/services/auth.dart';
import 'package:provider/provider.dart';

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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthenticationService().user,
      child: MaterialApp(
      title: 'My Notes',
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: "#A4036F".toColor(), //dark pink
        primaryColor: Color(0xFF16DB93), //green
        accentColor: Color(0x8C86AA) //purble
      ),
      home: Wrapper()
    ),
    );
  }
}