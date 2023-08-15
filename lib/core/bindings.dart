import 'package:meus_gastos/repositories/api/impl_api_repository.dart';
import 'package:meus_gastos/repositories/auth/impl_auth_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AppBindings extends StatelessWidget {
  const AppBindings({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ImplAuthRepository>(
          create: (context) => ImplAuthRepository(),
        ),
        Provider<ImplApiRepository>(
          create: (context) => ImplApiRepository(),
        ),
      ],
      child: child,
    );
  }
}
