import 'package:flutter/material.dart';
import 'package:meus_gastos/pages/categories_list/categories_list_router.dart';
import 'package:meus_gastos/pages/expenses/expenses_list_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? selectedIndex = 0; // Initialize with 0 for default page

  // Create the page instances here
  final expensesPage = ExpensesListRouter.page;
  final categoriesPage = CategoriesListRouter.page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.money_outlined),
              label: 'Lançamentos',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_box_outlined),
                label: 'Categorias',
            ),
          ],
        ),
        body: IndexedStack(
            index: selectedIndex,
            children: [
              expensesPage,
              categoriesPage,
            ],
        ),
    ); 
  }
}
