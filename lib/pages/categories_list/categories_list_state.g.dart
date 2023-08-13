// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_list_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension CategoriesListStatusMatch on CategoriesListStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == CategoriesListStatus.initial) {
      return initial();
    }

    if (v == CategoriesListStatus.loading) {
      return loading();
    }

    if (v == CategoriesListStatus.loaded) {
      return loaded();
    }

    if (v == CategoriesListStatus.error) {
      return error();
    }

    throw Exception(
        'CategoriesListStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == CategoriesListStatus.initial && initial != null) {
      return initial();
    }

    if (v == CategoriesListStatus.loading && loading != null) {
      return loading();
    }

    if (v == CategoriesListStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == CategoriesListStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
