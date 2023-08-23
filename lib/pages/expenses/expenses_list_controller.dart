import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/models/entry.dart';
import 'package:meus_gastos/pages/expenses/expenses_list_state.dart';
import 'package:meus_gastos/repositories/api/api_repository.dart';
import 'package:meus_gastos/repositories/auth/auth_repository.dart';

class ExpensesListController extends Cubit<ExpensesListState> {
  final AuthRepository authRepository;
  final ApiRepository apiRepository;
  final List<Entry> expenses;

  ExpensesListController(
      this.authRepository, this.apiRepository, this.expenses)
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
      final result = await apiRepository.getEntries(uid);
      emit(state.copyWith(
          status: ExpensesListStatus.loaded, expenses: result));
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
          status: ExpensesListStatus.loaded, expenses: expenses));
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
          status: ExpensesListStatus.loaded, expenses: updatedExpenses));
    } catch (e, s) {
      log("Erro ao remover gasto.", error: e, stackTrace: s);
      emit(state.copyWith(status: ExpensesListStatus.error));
      throw Exception("$e, $s");
    }
  }

  Future<void> updateEntry(Entry entry) async {
    try {
      emit(state.copyWith(status: ExpensesListStatus.loading));
      final uid = await authRepository.getUid();
      await apiRepository.updateEntry(uid, entry);
      final updatedExpenses = await apiRepository.getEntries(uid);
      emit(state.copyWith(
          status: ExpensesListStatus.loaded, expenses: updatedExpenses));
    } catch (e, s) {
      log("Erro ao atualizar categoria.", error: e, stackTrace: s);
      emit(state.copyWith(status: ExpensesListStatus.error));
      throw Exception("$e, $s");
    }
}
}