import 'package:flutter/material.dart';
import 'package:meus_gastos/pages/auth/login/login.dart';
import 'package:meus_gastos/pages/auth/login/login_controller.dart';
import 'package:meus_gastos/repositories/impl_auth_repository.dart';
import 'package:provider/provider.dart';

class LoginRouter {
  LoginRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => LoginController(
              context.read<ImplAuthRepository>(),
            ),
          ),
        ],
        child: const LoginScreen(),
      );
}