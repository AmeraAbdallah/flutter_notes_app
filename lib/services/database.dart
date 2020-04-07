import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final CollectionReference noteCollection = Firestore.instance.collection('notes');
  final uid;

  DatabaseService({this.uid});

  Future addToNotes(title, description) async {
    print(title + " " + description + " " + uid);
    return await noteCollection.add({
      'title': title,
      'description': description,
      'user': uid
    });
  }

  Stream<QuerySnapshot> get notes {
      return Firestore.instance.collection('notes').where('user', isEqualTo: uid).snapshots(); //not working probly
  }
}