import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/auth_user.dart';

class AuthNotifier extends StateNotifier<AuthUser?> {
  AuthNotifier() : super(null);
  final _auth = FirebaseAuth.instance;
  void syncUser() {
    if (_auth.currentUser == null) {
      state == null;
      return;
    }
    state =
        AuthUser(email: _auth.currentUser!.email, uid: _auth.currentUser!.uid);
  }

  Future<void> logout() async {
    await _auth.signOut();
    syncUser();
  }

  Future<void> signInWithEmailPassword(
      {required String email, required String password}) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      syncUser();
      debugPrint('Signed In successfully!');
    });
  }

  Future<void> signUpWithEmailPassword(
      {required String email, required String password}) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      syncUser();
      debugPrint('Signed In successfully!');
    });
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthUser?>((ref) => AuthNotifier());
