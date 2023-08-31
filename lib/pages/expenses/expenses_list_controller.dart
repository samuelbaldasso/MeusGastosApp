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
  final List<Entry>? expenses;
  final Entry? expense;

  ExpensesListController(this.authRepository, this.apiRepository, this.expenses,
      this.categories, this.expense)
      : super(ExpensesListState.initial());

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
      final result = await apiRepository.getEntries(uid);
      if (result.isNotEmpty) {
        emit(state.copyWith(
            status: ExpensesListStatus.loaded,
            expenses: result,
            categories: categories,
            expense: expense));
      } else {
        emit(state.copyWith(
            status: ExpensesListStatus.empty,
            expenses: [],
            categories: categories,
            expense: null));
      }
    } catch (e, s) {
      log("Erro ao carregar gastos.", error: e, stackTrace: s);
      emit(state.copyWith(status: ExpensesListStatus.error));
      throw Exception("$e, $s");
    }
  }

  Future<void> addEntry(Entry entry) async {
    try {
      emit(state.copyWith(status: ExpensesListStatus.loading));
      final uid = await authRepository.getUid();
      await apiRepository.saveEntry(uid, entry);
      emit(state.copyWith(
          status: ExpensesListStatus.loaded,
          expenses: expenses,
          categories: categories,
          expense: expense));
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
          expense: expense));
    } catch (e, s) {
      log("Erro ao remover gasto.", error: e, stackTrace: s);
      emit(state.copyWith(status: ExpensesListStatus.error));
      throw Exception("$e, $s");
    }
  }

   Entry? getExpenseById(int expenseId) {
    return state.expenses.firstWhere((expense) => expense.id == expenseId);
  }

  Future<void> updateEntry(Entry entry) async {
    try {
      emit(state.copyWith(status: ExpensesListStatus.loading));
      final uid = await authRepository.getUid();
      await apiRepository.updateEntry(uid, entry);
      final updatedExpenses = await apiRepository.getEntries(uid);
      final updatedCategories = await apiRepository.getData(uid);
      emit(state.copyWith(
          status: ExpensesListStatus.loaded,
          expenses: updatedExpenses,
          categories: updatedCategories,
          expense: expense));
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
