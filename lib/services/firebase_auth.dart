import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';

class FirebaseAuthServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<dynamic> signUp(String email, String password, String username) async {
    try {
      UserModel _user = UserModel(username: username, email: email);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _user.uid = userCredential.user!.uid;
      await createUser(_user);
      print('Success ${userCredential.user!.displayName}');
      return _user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return (e is PlatformException) ? e.message! : e.toString();
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final UserModel? loggedUser = await returnUser(userCredential.user!.uid);
      return loggedUser;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future<String> createUser(UserModel user) async {
    String retValue = 'error';
    try {
      await _firestore.collection("users").doc(user.uid).set(user.toMap());
      await _auth.currentUser!.updateDisplayName(user.username);

      retValue = 'success';
    } on FirebaseException catch (e) {
      retValue = e.message!;
    }

    return Future.value(retValue);
  }

  Future<dynamic> returnUser(String id) async {
    try {
      var userDoc = await _firestore.collection("users").doc(id).get();

      if (userDoc.data() != null) {
        UserModel? user = UserModel.fromMap(userDoc.data()!);
        print('USER RETURNED');
        return user;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future<UserModel?> checkAuth() async {
    if (_auth.currentUser != null) {
      final UserModel user = await returnUser(_auth.currentUser!.uid);
      return user;
    } else {
      return null;
    }
  }

  logout() async {
    await _auth.signOut();
  }
}
