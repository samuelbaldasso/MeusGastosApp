import 'package:meus_gastos/repositories/impl_auth_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AppBindings extends StatelessWidget {
  const AppBindings({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ 
        Provider(
          create: (context) => ImplAuthRepository(),
        )
      ],
      child: child,
    );
  }
}