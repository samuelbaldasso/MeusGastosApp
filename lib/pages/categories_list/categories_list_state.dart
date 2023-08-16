import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:meus_gastos/models/category.dart';

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

  const CategoriesListState({
    required this.status,
    required this.categories,
  });

  const CategoriesListState.initial()
      : status = CategoriesListStatus.initial,
        categories = const [];
  CategoriesListState copyWith({
    CategoriesListStatus? status,
    List<Category>? categories,
  }) {
    return CategoriesListState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [status, categories];
}
