import 'package:flutter/material.dart';
import 'package:meus_gastos/pages/auth/register/register.dart';
import 'package:meus_gastos/pages/auth/register/register_controller.dart';
import 'package:meus_gastos/repositories/auth/impl_auth_repository.dart';
import 'package:provider/provider.dart';

class RegisterRouter {
  RegisterRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => RegisterController(
              context.read<ImplAuthRepository>(),
            ),
          ),
        ],
        child: const RegisterScreen(),
      );
}