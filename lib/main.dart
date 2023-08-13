import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meus_gastos/core/bindings.dart';
import 'package:meus_gastos/firebase_options.dart';
import 'package:meus_gastos/pages/auth/login/login_router.dart';
import 'package:meus_gastos/pages/auth/register/register_router.dart';
import 'package:meus_gastos/pages/categories_list/categories_list_router.dart';
import 'package:meus_gastos/pages/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBindings(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meus Gastos',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: Color(0xff5EA3A3),
              unselectedItemColor: Color(0xff5EA3A3),
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              elevation: 1,
            ),
            useMaterial3: false,
          ),
          routes: {
            '/': (context) => LoginRouter.page,
            "/register": (context) => RegisterRouter.page,
            "/home": (context) => const HomePage(),
            "/categories":(context) => CategoriesListRouter.page,
          }
        ),
    );
  }
}
