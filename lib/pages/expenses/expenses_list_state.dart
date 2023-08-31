import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:meus_gastos/models/category.dart';
import 'package:meus_gastos/models/entry.dart';


@match
enum ExpensesListStatus {
  initial,
  loading,
  loaded,
  empty,
  error,
}

class ExpensesListState extends Equatable {
  final ExpensesListStatus status;
  final List<Entry> expenses;
  final List<Category> categories;
  final Entry expense;

  const ExpensesListState({
    required this.status,
    required this.expenses,
    required this.categories,
    required this.expense
  });

  ExpensesListState.initial()
      : status = ExpensesListStatus.initial,
        expenses = const [],
        categories = const [],
        expense = Entry(name: "", value: 0.0);

  ExpensesListState copyWith({
    ExpensesListStatus? status,
    List<Entry>? expenses, List<Category>? categories, Entry? expense
  }) {
    return ExpensesListState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      categories: categories ?? this.categories,
      expense: expense ?? this.expense
    );
  }

  @override
  List<Object?> get props => [status, expenses, categories, expense];
}
