import 'package:flutter/material.dart';
import 'package:note_app/models/user.dart';
import 'package:note_app/screens/authentication/authenticate.dart';
import 'package:note_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    return user == null? Authenticate(): Home();
  }
}