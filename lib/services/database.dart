import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final CollectionReference noteCollection = Firestore.instance.collection('notes');
  final uid;

  DatabaseService({this.uid});

  Future addToNotes(String title, String description) async {
    return await noteCollection.add({
      'title': title,
      'description': description,
      'user': uid
    });
  }

    Stream<QuerySnapshot> get notes {
    return noteCollection.where('user', isEqualTo: uid).snapshots();
  }

}