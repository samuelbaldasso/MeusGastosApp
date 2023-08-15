import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/pages/auth/register/register_state.dart';
import 'package:meus_gastos/repositories/auth/auth_repository.dart';

class RegisterController extends Cubit<RegisterState> {
  final AuthRepository _authRepository;
  RegisterController(this._authRepository) : super(const RegisterState.initial());

  Future<void> register(String email, String password) async {
    try {
      emit(state.copyWith(status: RegisterStatus.register));
      await _authRepository.register(email, password);
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (e) {
      log('Erro ao registrar usuário.');
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}