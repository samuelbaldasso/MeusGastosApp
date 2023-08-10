import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meus_gastos/pages/auth/login/login_state.dart';
import 'package:meus_gastos/repositories/auth_repository.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository) : super(const LoginState.initial());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      await _authRepository.login(email: email, password: password);
      await _authRepository.reload();
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e, s) {
      log("Erro ao realizar login.", error: e, stackTrace: s);
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
