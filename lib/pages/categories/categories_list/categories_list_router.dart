import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:meus_gastos/pages/categories/categories_list/categories_list.dart';
import 'package:meus_gastos/pages/categories/categories_list/categories_list_controller.dart';
import 'package:meus_gastos/repositories/impl_auth_repository.dart';

class CategoriesListRouter {
  CategoriesListRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => CategoriesListController(
              context.read<ImplAuthRepository>(),
            ),
          ),
        ],
        child: const CategoriesList(),
      );
}