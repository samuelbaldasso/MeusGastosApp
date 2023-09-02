import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:meus_gastos/models/category.dart';
import 'package:meus_gastos/models/entry.dart';

@match
enum ExpensesListStatus {
  initial,
  loading,
  loaded,
  error,
}

class ExpensesListState extends Equatable {
  final ExpensesListStatus status;
  final List<Entry> expenses;
  final List<Category> categories;

  const ExpensesListState({
    required this.status,
    required this.expenses,
    required this.categories,
  });

  const ExpensesListState.initial()
      : status = ExpensesListStatus.initial,
        expenses = const [],
        categories = const [];

  ExpensesListState copyWith(
      {ExpensesListStatus? status,
      List<Entry>? expenses,
      List<Category>? categories,
      }) {
    return ExpensesListState(
        status: status ?? this.status,
        expenses: expenses ?? this.expenses,
        categories: categories ?? this.categories,
        );
  }

  @override
  List<Object?> get props => [status, expenses, categories];
}
