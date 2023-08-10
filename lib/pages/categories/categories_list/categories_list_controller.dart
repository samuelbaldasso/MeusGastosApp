import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/pages/categories/categories_list/categories_list_state.dart';
import 'package:meus_gastos/repositories/auth_repository.dart';

class CategoriesListController extends Cubit<CategoriesListState>{
  final AuthRepository authRepository;
  CategoriesListController(this.authRepository) : super(const CategoriesListState.initial());

Future<void> logout() async {
    try {
      authRepository.logout();
    } catch (e, s) {
      log("Erro ao realizar login.", error: e, stackTrace: s);
      emit(state.copyWith(status: CategoriesListStatus.error));
    }
}

}