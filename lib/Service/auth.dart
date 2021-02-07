import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:net_ninja_coffee/Service/database.dart';
import 'package:net_ninja_coffee/models/user.dart';

class AuthService {
  //_ makes atttribute final****
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase returned user

  TheUser _userFromFireBase(User u) {
    return u != null ? TheUser(uid: u.uid) : null;
  }

  //auth change user stream

  Stream<TheUser> get users {
    return _auth
        .authStateChanges()
        // .map((User u) => _userFromFireBase(u)); // long way
        .map(_userFromFireBase);
  }

  //signing with ano
  Future signInAnon() async {
    try {
      UserCredential res = await _auth.signInAnonymously();
      User user = res.user;
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signin with email pw

  Future SignIn(String email, String pw) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pw);
      User user = result.user;
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //create user with email

  Future CreatUser(String email, String pw) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pw);
      User user = result.user;

      //this is to create coffe colection as soon as user is registred
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'New Member', 100);
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //logout
  Future Signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
