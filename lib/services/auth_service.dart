import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Service to manage Firebase authentication.
class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  bool get isAuthenticated => currentUser != null;

  /// Signs in a user using email and password.
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners(); // Notify listeners of auth state change
      return userCredential.user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  /// Registers a user using email and password.
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners(); // Notify listeners of auth state change
      return userCredential.user;
    } catch (e) {
      print('Error registering: $e');
      return null;
    }
  }

  /// Signs out the currently signed-in user.
  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners(); // Notify listeners of auth state change
  }
}
