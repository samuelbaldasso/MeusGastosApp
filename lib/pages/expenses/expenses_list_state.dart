import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
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

  const ExpensesListState({
    required this.status,
    required this.expenses,
  });

  const ExpensesListState.initial()
      : status = ExpensesListStatus.initial,
        expenses = const [];
  ExpensesListState copyWith({
    ExpensesListStatus? status,
    List<Entry>? expenses,
  }) {
    return ExpensesListState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
    );
  }

  @override
  List<Object?> get props => [status, expenses];
}
