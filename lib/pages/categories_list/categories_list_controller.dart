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

  CategoriesListController(
      this.authRepository, this.apiRepository, this.categories)
      : super(const CategoriesListState.initial());

  Future<void> logout() async {
    try {
      authRepository.logout();
    } catch (e, s) {
      log("Erro ao realizar login.", error: e, stackTrace: s);
      super.emit(state.copyWith(status: CategoriesListStatus.error));
    }
  }

  Future<void> loadCategories() async {
    try {
      emit(state.copyWith(status: CategoriesListStatus.loading));
      final uid = await authRepository.getUid();
      final result = await apiRepository.getData(uid);
      emit(state.copyWith(
          status: CategoriesListStatus.loaded, categories: result));
    } catch (e, s) {
      log("Erro ao carregar categorias.", error: e, stackTrace: s);
      emit(state.copyWith(status: CategoriesListStatus.error));
      throw Exception("$e, $s");
    }
  }

  // Future<Category> loadById(Category category) async {
  //   try {
  //     emit(state.copyWith(status: CategoriesListStatus.loading));
  //     final uid = await authRepository.getUid();
  //     final cat = await apiRepository.getDataById(uid, category.id ?? 0);
  //     emit(state.copyWith(
  //         status: CategoriesListStatus.loaded, categories: categories));
  //     return cat;
  //   } catch (e, s) {
  //     log("Erro ao carregar categoria.", error: e, stackTrace: s);
  //     emit(state.copyWith(status: CategoriesListStatus.error));
  //     throw Exception("$e, $s");
  //   }
  // }

  Future<void> addCategory(Category category) async {
    try {
      emit(state.copyWith(status: CategoriesListStatus.loading));
      final uid = await authRepository.getUid();
      await apiRepository.saveData(uid, category);
      emit(state.copyWith(
          status: CategoriesListStatus.loaded, categories: categories));
    } catch (e, s) {
      log("Erro ao adicionar categoria.", error: e, stackTrace: s);
      emit(state.copyWith(status: CategoriesListStatus.error));
      throw Exception("$e, $s");
    }
  }

  Future<void> deleteCategory(Category category) async {
    try {
      emit(state.copyWith(status: CategoriesListStatus.loading));
      final uid = await authRepository.getUid();
      await apiRepository.deleteData(uid, category.id!);
      final updatedCategories =
          state.categories.where((c) => c.id != category.id).toList();
      emit(state.copyWith(
          status: CategoriesListStatus.loaded, categories: updatedCategories));
    } catch (e, s) {
      log("Erro ao remover categoria.", error: e, stackTrace: s);
      emit(state.copyWith(status: CategoriesListStatus.error));
      throw Exception("$e, $s");
    }
  }

  Future<void> updateCategory(Category category) async {
    try {
      emit(state.copyWith(status: CategoriesListStatus.loading));
      final uid = await authRepository.getUid();
      await apiRepository.updateData(uid, category);
      final updatedCategories = await apiRepository.getData(uid);
      emit(state.copyWith(
          status: CategoriesListStatus.loaded, categories: updatedCategories));
    } catch (e, s) {
      log("Erro ao atualizar categoria.", error: e, stackTrace: s);
      emit(state.copyWith(status: CategoriesListStatus.error));
      throw Exception("$e, $s");
    }
  }
}
