import 'package:flutter/material.dart';
import 'package:meus_gastos/pages/categories_list/categories_list_router.dart';
import 'package:meus_gastos/pages/expenses/expenses_list_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          //Create a logic for selectedIndex
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.money_outlined,
              ),
              label: 'Lançamentos',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_box_outlined,
                ),
                label: 'Categorias',
                ),
          ],
        ),
        body: selectedIndex == 1 ? CategoriesListRouter.page : ExpensesListRouter.page,
    ); 
  }
}