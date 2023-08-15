import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:meus_gastos/models/category.dart';

part 'categories_list_state.g.dart';

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

  const CategoriesListState.initial(this.categories) : status = CategoriesListStatus.initial;

  CategoriesListState copyWith({
    CategoriesListStatus? status,
  }) {
    return CategoriesListState(
      status: status ?? this.status, categories: categories,
    );
  }

  @override
  List<Object?> get props => [status];
}