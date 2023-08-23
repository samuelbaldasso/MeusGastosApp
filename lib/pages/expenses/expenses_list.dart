import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/core/base_state.dart';
import 'package:meus_gastos/models/category.dart';
import 'package:meus_gastos/models/entry.dart';
import 'package:meus_gastos/pages/expenses/expenses_list_controller.dart';
import 'package:meus_gastos/pages/expenses/expenses_list_state.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({super.key});

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState
    extends BaseState<ExpensesList, ExpensesListController> {
  final GlobalKey<FormState> key = GlobalKey();
  final GlobalKey<FormState> keyEdit = GlobalKey();
  final addController = TextEditingController();
  final addControllerValue = TextEditingController();
  final categoryEditController = TextEditingController();
  final descriptionEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final scaffold = ScaffoldMessenger.of(context);
    // var isChecked = false;
    final list = List.generate(10, (index) {
      return index + 1;
    });
    return BlocBuilder<ExpensesListController, ExpensesListState>(
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 36.0, left: 8.0, bottom: 18.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Adicionar lançamento",
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
                                          margin: const EdgeInsets.only(
                                              bottom: 16.0),
                                          padding: const EdgeInsets.only(left: 8.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.grey.withOpacity(0.05),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: TextFormField(
                                              controller: addController,
                                              decoration: InputDecoration(
                                                hintText: "ex: Internet",
                                                labelText: "Gasto",
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
                                                  return "Gasto obrigatório";
                                                }
                                                return null;
                                              }),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                              margin: const EdgeInsets.only(bottom: 16.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.grey.withOpacity(0.05),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style:
                                                          ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              elevation: 3),
                                                      child: const Text(
                                                        "Entrada",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style:
                                                          ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        elevation: 3,
                                                      ),
                                                      child: const Text(
                                                        "Saída",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.grey.withOpacity(0.05),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10)),
                                          ),
                                          child: TextFormField(
                                              controller: addControllerValue,
                                              decoration: InputDecoration(
                                                  hintText: "R\$ 0,00",
                                                  labelText: "Valor",
                                                  labelStyle: TextStyle(
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                  ),
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  border: InputBorder.none,
                                                  fillColor: Colors.orange,
                                                  prefixIcon: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 16.0),
                                                    width:
                                                        50, // largura do ícone
                                                    height:
                                                        50, // altura do ícone
                                                    decoration: const BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10.0)) // cor de fundo desejada
                                                        ),
                                                    child: const Icon(
                                                      Icons
                                                          .arrow_downward, // ícone desejado
                                                      color: Colors
                                                          .white, // cor do ícone
                                                      size:
                                                          30, // tamanho do ícone
                                                    ),
                                                  )),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Gasto obrigatório";
                                                }
                                                return null;
                                              }),
                                        ),
                                        // DropdownButton(
                                        //   items: [],
                                        //   onChanged: (value) {},
                                        //   dropdownColor:
                                        //       Colors.grey.withOpacity(0.05),
                                        //   borderRadius: const BorderRadius.only(
                                        //       topLeft: Radius.circular(10),
                                        //       topRight: Radius.circular(10)),
                                        // ),

                                        // DropdownButton(
                                        //   items: [],
                                        //   onChanged: (value) {},
                                        //   dropdownColor:
                                        //       Colors.grey.withOpacity(0.05),
                                        //   borderRadius: const BorderRadius.only(
                                        //       topLeft: Radius.circular(10),
                                        //       topRight: Radius.circular(10)),
                                        // ),
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
                                              if (key.currentState
                                                      ?.validate() ??
                                                  false) {
                                                scaffold.showSnackBar(
                                                    const SnackBar(
                                                  content: Text(
                                                      "Gasto adicionado com sucesso!"),
                                                  duration: Duration(
                                                    seconds: 2,
                                                  ),
                                                ));
                                                nav.pop();
                                                controller.loadExpenses();
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
                          "Gastos",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                    if (state.status == ExpensesListStatus.loading)
                      const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Color(
                            (0xff5EA3A3),
                          ),
                        ),
                      ),
                    if (state.status == ExpensesListStatus.loaded)
                      if (state.expenses.isEmpty)
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
                          itemCount: state.expenses.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(state.expenses[index].id.toString()),
                              onDismissed: (direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  await controller
                                      .deleteCategory(state.expenses[index]);
                                  scaffold.showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Categoria excluída com sucesso"),
                                    ),
                                  );
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
                                                          controller:
                                                              categoryEditController,
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
                                                                  descriptionEditController,
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
                                                          nav.pop();
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
                                                      onPressed: () async {
                                                        await controller
                                                            .loadExpenses();
                                                        categoryEditController
                                                            .clear();
                                                        descriptionEditController
                                                            .clear();
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
                              secondaryBackground: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20.0),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              background: Container(
                                color: Colors.green,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 20.0),
                                child:
                                    const Icon(Icons.edit, color: Colors.white),
                              ),
                              child: ListTile(
                                title:
                                    Text(state.expenses[index].category.name),
                                subtitle: Text(
                                    state.expenses[index].category.description),
                              ),
                            );
                          },
                        ),
                    if (state.status == ExpensesListStatus.error)
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
