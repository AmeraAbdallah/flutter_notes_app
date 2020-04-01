import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final CollectionReference noteCollection = Firestore.instance.collection('notes');
  
}