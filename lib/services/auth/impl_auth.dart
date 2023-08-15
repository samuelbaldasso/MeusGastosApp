import 'package:firebase_auth/firebase_auth.dart';
import 'package:meus_gastos/repositories/auth/auth_repository.dart';
import 'package:meus_gastos/services/auth/auth.dart';

class ImplAuthService implements AuthService {
  final AuthRepository authRepository;

  ImplAuthService({
    required this.authRepository,
  });

  @override
  Stream<User?> get user => authRepository.user;

  @override
  Future register(String email, String password) async =>
      authRepository.register(email, password);

  @override
  login({required String email, required String password}) async =>
      authRepository.login(email: email, password: password);

  @override
  logout() async => authRepository.logout();

  @override
  resetPassword(String email) async => authRepository.resetPassword(email);

  @override
  Future<void> sendEmailVerification() async =>
      authRepository.sendEmailVerification();

  @override
  Future<void> reload() => authRepository.reload();
}
