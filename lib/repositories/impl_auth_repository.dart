import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import './auth_repository.dart';

class ImplAuthRepository implements AuthRepository {
  @override
  Stream<User?> get user => FirebaseAuth.instance.authStateChanges();

@override
  Future register(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

@override
  login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

@override
  logout() async {
    await FirebaseAuth.instance.signOut();
  }

@override
  resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

@override
  Future<void> sendEmailVerification() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

@override
  Future<void> reload(){
    return FirebaseAuth.instance.currentUser!.reload();
  } 
}