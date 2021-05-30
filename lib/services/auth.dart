import 'package:coffee_app/models/user.dart';
import 'package:coffee_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 100, 'Enter Name');
      return _anonUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _anonUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //stream for user auth
  Stream<AnonUser> get user {
    return _auth.authStateChanges().map(_anonUserFromFirebaseUser);
  }

  //userobject from firebase user

  AnonUser _anonUserFromFirebaseUser(User user) {
    if (user != null) {
      return AnonUser(uid: user.uid);
    } else {
      return null;
    }
  }

  //sign in anon

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _anonUserFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
