import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/models/category.dart';
import 'package:meus_gastos/models/entry.dart';
import 'package:meus_gastos/pages/expenses/expenses_list_state.dart';
import 'package:meus_gastos/repositories/api/api_repository.dart';
import 'package:meus_gastos/repositories/auth/auth_repository.dart';

class ExpensesListController extends Cubit<ExpensesListState> {
  final AuthRepository authRepository;
  final ApiRepository apiRepository;
  final List<Category> categories;
  final List<Entry> expenses;
  final Entry? expense;

  ExpensesListController(this.authRepository, this.apiRepository, this.expenses,
      this.categories, this.expense)
      : super(const ExpensesListState.initial());

  Future<void> logout() async {
    try {
      authRepository.logout();
    } catch (e, s) {
      log("Erro ao realizar login.", error: e, stackTrace: s);
      super.emit(state.copyWith(status: ExpensesListStatus.error));
    }
  }

  Future<void> loadExpenses() async {
    try {
      emit(state.copyWith(status: ExpensesListStatus.loading));
      final uid = await authRepository.getUid();
      final expensesList = await apiRepository.getEntries(uid);
      final categoriesList = await apiRepository.getData(uid);
      emit(state.copyWith(
        status: ExpensesListStatus.loaded,
        expenses: expensesList,
        categories: categoriesList,
      ));
    } catch (e, s) {
      log("Erro ao carregar gastos.", error: e, stackTrace: s);
      emit(state.copyWith(status: ExpensesListStatus.error));
      throw Exception("$e, $s");
    }
  }

    Future<void> deleteCategory(Category category) async {
    try {
      emit(state.copyWith(status: ExpensesListStatus.loading));
      final uid = await authRepository.getUid();
      await apiRepository.deleteData(uid, category.id!);
      final updatedCategories =
          state.categories.where((c) => c.id != category.id).toList();
      emit(state.copyWith(
          status: ExpensesListStatus.loaded, categories: updatedCategories, expenses: expenses));
    } catch (e, s) {
      log("Erro ao remover categoria.", error: e, stackTrace: s);
      emit(state.copyWith(status: ExpensesListStatus.error));
      throw Exception("$e, $s");
    }
  }

  Future<void> addEntry(Entry entry, int id) async {
    try {
      emit(state.copyWith(status: ExpensesListStatus.loading));
      final uid = await authRepository.getUid();
      await apiRepository.saveEntry(uid, entry, id);

      // Add the new entry to the existing list of expenses
      List<Entry> updatedExpenses = await apiRepository.getEntries(uid);
      
      emit(state.copyWith(
        status: ExpensesListStatus.loaded,
        expenses: updatedExpenses,
        categories: categories,
      ));
    } catch (e, s) {
      log("Erro ao adicionar gasto.", error: e, stackTrace: s);
      emit(state.copyWith(status: ExpensesListStatus.error));
      throw Exception("$e, $s");
    }
  }

  Future<void> deleteEntry(Entry entry) async {
    try {
      emit(state.copyWith(status: ExpensesListStatus.loading));
      final uid = await authRepository.getUid();
      await apiRepository.deleteEntry(uid, entry.id!);
      final updatedExpenses =
          state.expenses.where((c) => c.id != entry.id).toList();
      emit(state.copyWith(
        status: ExpensesListStatus.loaded,
        expenses: updatedExpenses,
        categories: categories,
      ));
    } catch (e, s) {
      log("Erro ao remover gasto.", error: e, stackTrace: s);
      emit(state.copyWith(status: ExpensesListStatus.error));
      throw Exception("$e, $s");
    }
  }

  Future<void> updateEntry(Entry entry, int id) async {
    try {
      emit(state.copyWith(status: ExpensesListStatus.loading));
      final uid = await authRepository.getUid();
      await apiRepository.updateEntry(uid, entry, id);
      final updatedExpenses = await apiRepository.getEntries(uid);
      final updatedCategories = await apiRepository.getData(uid);
      emit(state.copyWith(
        status: ExpensesListStatus.loaded,
        expenses: updatedExpenses,
        categories: updatedCategories,
      ));
    } catch (e, s) {
      log("Erro ao atualizar categoria.", error: e, stackTrace: s);
      emit(state.copyWith(status: ExpensesListStatus.error));
      throw Exception("$e, $s");
    }
  }

  double getTotalOut(List<Entry> expenses) {
    double total = 0;
    for (var expense in expenses) {
      if (expense.entryType == "1") {
        total += expense.value;
      }
    }
    return total;
  }

  double getTotalIn(List<Entry> expenses) {
    double total = 0;
    for (var expense in expenses) {
      if (expense.entryType == "0") {
        total += expense.value;
      }
    }
    return total;
  }
}
