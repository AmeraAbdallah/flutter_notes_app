import 'package:flutter/material.dart';
import 'package:note_app/models/user.dart';
import 'package:note_app/screens/wrapper.dart';
import 'package:note_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthenticationService().user,
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Wrapper()
    ),
    );
  }
}