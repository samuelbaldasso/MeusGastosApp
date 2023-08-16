import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/core/base_state.dart';
import 'package:meus_gastos/models/category.dart';
import 'package:meus_gastos/pages/categories_list/categories_list_controller.dart';
import 'package:meus_gastos/pages/categories_list/categories_list_state.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState
    extends BaseState<CategoriesList, CategoriesListController> {
  final GlobalKey<FormState> key = GlobalKey();
  final category = TextEditingController();
  final description = TextEditingController();

  @override
  void dispose() {
    category.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final scaffold = ScaffoldMessenger.of(context);
    return BlocBuilder<CategoriesListController, CategoriesListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            centerTitle: false,
            title: InkWell(
              onTap: () {
                controller.logout();
                nav.popAndPushNamed("/");
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Color(0xff5EA3A3)),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        context: context,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: .9,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 36.0, left: 8.0, bottom: 18.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Adicionar Categorias",
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ),
                                Form(
                                  key: key,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.05),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: TextFormField(
                                              controller: category,
                                              decoration: InputDecoration(
                                                hintText: "ex: Casa",
                                                labelText: "Nome da categoria",
                                                labelStyle: TextStyle(
                                                    color: Colors.grey
                                                        .withOpacity(0.7)),
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none,
                                                fillColor: Colors.grey,
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Categoria obrigatória";
                                                }
                                                return null;
                                              }),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                            top: 34.0,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.05),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: TextFormField(
                                                  controller: description,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "ex: Gastos relacionados a moradia...",
                                                    labelText:
                                                        "Descrição da categoria",
                                                    labelStyle: TextStyle(
                                                        color: Colors.grey
                                                            .withOpacity(0.7)),
                                                    hintStyle: const TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                    border: InputBorder.none,
                                                    fillColor: Colors.grey,
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Descrição obrigatória";
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          )),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 48.0,
                                          bottom: 36.0,
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (key.currentState?.validate() ??
                                                false) {
                                                  await controller.addCategory(Category(name: category.text, description: description.text));
                                                  scaffold.showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Categoria adicionada com sucesso!"),
                                                    duration: Duration(
                                                      seconds: 2,
                                                    ),
                                                  ));
                                                  nav.pop();
                                                  controller.loadCategories();
                                                }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff5EA3A3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            padding: const EdgeInsets.only(
                                                top: 18.0, bottom: 18.0),
                                          ),
                                          child: const Text(
                                            "SALVAR",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            nav.pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff5EA3A3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            padding: const EdgeInsets.only(
                                                top: 18.0, bottom: 18.0),
                                          ),
                                          child: const Text(
                                            "CANCELAR",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xff5EA3A3),
                  )),
            ],
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   //Create a logic for selectedIndex
          //   onTap: (index) {
          //     setState(() {
          //       selectedIndex = index;
          //     });
          //   },
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: Icon(
          //         Icons.money_outlined,
          //       ),
          //       label: 'Lançamentos',
          //     ),
          //     BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.check_box_outlined,
          //         ),
          //         label: 'Categorias'),
          //   ],
          //   currentIndex: selectedIndex,
          // ),

          body: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 8.0, bottom: 36.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    if (state.status == CategoriesListStatus.loading)
                      const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Color(
                            (0xff5EA3A3),
                          ),
                        ),
                      ),
                    if (state.status == CategoriesListStatus.loaded)
                      if (state.categories.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Nenhum lançamento nesse período",
                              style: TextStyle(
                                color: Color(0xff5EA3A3),
                                fontSize: 25,
                              ),
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(state.categories[index].id.toString()),
                              onDismissed: (direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  await controller
                                      .deleteCategory(state.categories[index]);
                                  scaffold.showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Categoria excluída com sucesso"),
                                    ),
                                  );
                                  category.clear();
                                  description.clear();
                                } else if (direction ==
                                    DismissDirection.startToEnd) {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) {
                                        return FractionallySizedBox(
                                          heightFactor: .9,
                                          child: Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 36.0,
                                                  left: 8.0,
                                                  bottom: 18.0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Editar Categorias",
                                                  style: TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Form(
                                              key: key,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.05),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: TextFormField(
                                                          controller: category,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "ex: Casa",
                                                            labelText:
                                                                "Nome da categoria",
                                                            labelStyle: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.7)),
                                                            hintStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                            border: InputBorder
                                                                .none,
                                                            fillColor:
                                                                Colors.grey,
                                                          ),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return "Categoria obrigatória";
                                                            }
                                                            return null;
                                                          }),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 34.0,
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.05),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: TextFormField(
                                                              controller:
                                                                  description,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "ex: Gastos relacionados a moradia...",
                                                                labelText:
                                                                    "Descrição da categoria",
                                                                labelStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.7)),
                                                                hintStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                fillColor:
                                                                    Colors.grey,
                                                              ),
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return "Descrição obrigatória";
                                                                }
                                                                return null;
                                                              }),
                                                        ),
                                                      )),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 48.0,
                                                      bottom: 36.0,
                                                    ),
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        if (key.currentState
                                                                ?.validate() ??
                                                            false) {
                                                              
                                                            }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xff5EA3A3),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 18.0,
                                                                bottom: 18.0),
                                                      ),
                                                      child: const Text(
                                                        "SALVAR",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        nav.pop();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xff5EA3A3),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 18.0,
                                                                bottom: 18.0),
                                                      ),
                                                      child: const Text(
                                                        "CANCELAR",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                        );
                                      });
                                }
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20.0),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              child: ListTile(
                                title: Text(state.categories[index].name),
                                subtitle:
                                    Text(state.categories[index].description),
                              ),
                            );
                          },
                        ),
                    if (state.status == CategoriesListStatus.error)
                      const Center(
                        child: Text(
                          "Erro ao carregar categorias.",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                          ),
                        ),
                      ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
