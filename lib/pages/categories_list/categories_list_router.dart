import 'package:flutter/material.dart';
import 'package:meus_gastos/repositories/api/impl_api_repository.dart';
import 'package:provider/provider.dart';

import 'package:meus_gastos/pages/categories_list/categories_list.dart';
import 'package:meus_gastos/pages/categories_list/categories_list_controller.dart';
import 'package:meus_gastos/repositories/auth/impl_auth_repository.dart';

class CategoriesListRouter {
  CategoriesListRouter._();

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
            ),
          ),
        ],
        child: const CategoriesList(),
      );
}
