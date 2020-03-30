import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/models/user.dart';

class AuthenticationService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User _fromFirebaseUserToUser(FirebaseUser firebaseUser) {
    return firebaseUser != null ?  User(uid: firebaseUser.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_fromFirebaseUserToUser);
  }

  Future loginAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser firebaseUser = result.user;
      return _fromFirebaseUserToUser(firebaseUser);
    } catch(err) {
      print(err.toString());
      return null;
    }
  }

  Future createUserUsingEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _fromFirebaseUserToUser(firebaseUser);
    } catch(err) {
      print(err.toString());
      return null;
    }
  }

  Future logout() async {
    try {
      return await _auth.signOut();
    } catch(err) {
      return null;
    }
  }
}