import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/pages/categories_list/categories_list_controller.dart';
import 'package:meus_gastos/pages/expenses/expenses_list.dart';
import 'package:meus_gastos/pages/expenses/expenses_list_controller.dart';
import 'package:meus_gastos/repositories/api/impl_api_repository.dart';
import 'package:provider/provider.dart';

import 'package:meus_gastos/repositories/auth/impl_auth_repository.dart';

class ExpensesListRouter {
  ExpensesListRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => ImplAuthRepository(),
          ),
          Provider(
            create: (context) => ImplApiRepository(),
          ),
          Provider(
            create: (context) => CategoriesListController(
              context.read<ImplAuthRepository>(),
              context.read<ImplApiRepository>(),
              [],
              []
            ),
          ),
          ProxyProvider2<ImplAuthRepository, ImplApiRepository, ExpensesListController>(
            update: (context, authRepo, apiRepo, _) => ExpensesListController(
                authRepo,
                apiRepo,
                [],
                context.read<CategoriesListController>().state.categories,
                null,
            ),
          ),
        ],
        child: const ExpensesList(),
      );
}
