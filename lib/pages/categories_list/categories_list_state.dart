import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:meus_gastos/models/category.dart';
import 'package:meus_gastos/models/entry.dart';

@match
enum CategoriesListStatus {
  initial,
  loading,
  loaded,
  error,
}

class CategoriesListState extends Equatable {
  final CategoriesListStatus status;
  final List<Category> categories;
  final List<Entry> entries;

  const CategoriesListState({
    required this.status,
    required this.categories,
    required this.entries,
  });

  const CategoriesListState.initial()
      : status = CategoriesListStatus.initial,
        categories = const [],
        entries = const [];
  CategoriesListState copyWith({
    CategoriesListStatus? status,
    List<Category>? categories,
    List<Entry>? entries,
  }) {
    return CategoriesListState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      entries: entries ?? this.entries,
    );
  }

  @override
  List<Object?> get props => [status, categories, entries];
}
