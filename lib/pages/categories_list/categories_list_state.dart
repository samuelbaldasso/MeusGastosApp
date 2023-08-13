import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

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

  const CategoriesListState({
    required this.status,
  });

  const CategoriesListState.initial() : status = CategoriesListStatus.initial;

  CategoriesListState copyWith({
    CategoriesListStatus? status,
  }) {
    return CategoriesListState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}