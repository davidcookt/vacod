import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:vacod/providers/login.dart';

class SignUpProvider extends ChangeNotifier {
  FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;
  AppState? _appState;

  AppState get appState => _appState!;

  Future<void> signUp(String username, String email, String password) async {
    try {
      print('abc');
      _appState = AppState.authenticating; //set current state to loading state.
      notifyListeners();
      var createUser = await _auth!
          .createUserWithEmailAndPassword(email: email, password: password);
      print(createUser);
      await _firestore!.collection('user').add({
        'uid': createUser.user!.uid,
        'username': username,
      });
      return;
    } catch (e) {
      _appState = AppState.unauthenticated;
      notifyListeners();
      return;
    }
  }
}
