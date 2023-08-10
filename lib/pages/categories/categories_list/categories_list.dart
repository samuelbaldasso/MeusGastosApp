import 'package:flutter/material.dart';
import 'package:meus_gastos/pages/categories/categories_list/categories_list_controller.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    var selectedIndex = 1;
    final nav = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () {
            context.read<CategoriesListController>().logout();
            nav.popAndPushNamed("/");
          },
          child: const Text(
            'Logout',
            style: TextStyle(color: Color(0xff5EA3A3)),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Color(0xff5EA3A3),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
              label: 'Categorias'),
        ],
        currentIndex: selectedIndex,
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, bottom: 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Categorias",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   "Nenhum lançamento neste período",
                    //   style: TextStyle(fontSize: 22, color: Color(0xff5EA3A3)),
                    // ),
                      CircularProgressIndicator.adaptive(backgroundColor: Color(0xff5ea3a3)),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
