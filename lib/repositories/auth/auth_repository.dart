import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> login({required String email, required String password});
  void logout();
  Future<void> reload();
  Stream<User?> get user;
  Future<void> resetPassword(String email);
  Future<void> sendEmailVerification();
  Future register(String email, String password);
  Future<String> getUid();
}
