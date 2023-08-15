import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/models/category.dart';
import 'package:meus_gastos/pages/categories_list/categories_list_state.dart';
import 'package:meus_gastos/repositories/api/api_repository.dart';
import 'package:meus_gastos/repositories/auth/auth_repository.dart';

class CategoriesListController extends Cubit<CategoriesListState> {
  final AuthRepository authRepository;
  final ApiRepository apiRepository;
  final List<Category> categories;
  CategoriesListController(this.authRepository, this.apiRepository, this.categories)
      : super(CategoriesListState.initial(categories));
      
  Future<void> logout() async {
    try {
      authRepository.logout();
    } catch (e, s) {
      log("Erro ao realizar login.", error: e, stackTrace: s);
      emit(state.copyWith(status: CategoriesListStatus.error));
    }
  }

  Future<List<Category>> loadCategories(String uid) async {
    try {
      emit(state.copyWith(status: CategoriesListStatus.loading));
      final result = await apiRepository.getData(uid);
      emit(state.copyWith(status: CategoriesListStatus.loaded));
      return result as List<Category>;
    } catch (e, s) {
      log("Erro ao realizar login.", error: e, stackTrace: s);
      emit(state.copyWith(status: CategoriesListStatus.error));
      throw Exception("$e, $s");
    }
  }
}
