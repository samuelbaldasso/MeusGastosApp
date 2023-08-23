import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/core/base_state.dart';
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
  void initState() {
    super.initState();
    controller.loadExpenses();
  }

  @override
  void dispose() {
    addController.dispose();
    addControllerValue.dispose();
    categoryEditController.dispose();
    descriptionEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final scaffold = ScaffoldMessenger.of(context);
    var selectedIndex = [true, false];
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
                                        margin:
                                            const EdgeInsets.only(bottom: 16.0),
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.05),
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
                                        margin:
                                            const EdgeInsets.only(bottom: 16.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.05),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        elevation: 3,
                                                        disabledBackgroundColor:
                                                            const Color(
                                                                0xff5EA3A3)),
                                                    child: const Text(
                                                      "Entrada",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.white,
                                                      elevation: 3,
                                                    ),
                                                    child: const Text(
                                                      "Saída",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Colors.black54),
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
                                          color: Colors.grey.withOpacity(0.05),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
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
                                                  margin: const EdgeInsets.only(
                                                      right: 16.0),
                                                  width: 50,
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10.0))),
                                                  child: const Icon(
                                                    Icons.arrow_downward,
                                                    color: Colors.white,
                                                    size: 30,
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
                                      DropdownButton(
                                        items: [],
                                        value: "Categoria",
                                        onChanged: (value) {},
                                        dropdownColor:
                                            Colors.grey.withOpacity(0.05),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                      ),
                                      DropdownButton(
                                        items: [],
                                        onChanged: (value) {},
                                        value: "Data",
                                        dropdownColor:
                                            Colors.grey.withOpacity(0.05),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                      ),
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
                                              await controller.addEntry(Entry(
                                                  name: addController.text,
                                                  value: double.parse(
                                                      addControllerValue
                                                          .text)));
                                              scaffold
                                                  .showSnackBar(const SnackBar(
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
        // bottomNavigationBar: BottomNavigationBar(
        //   onTap: (index) {
        //     setState(() {
        //       selectedIndex[index] = !selectedIndex[index];
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
        //       icon: Icon(
        //         Icons.check_box_outlined,
        //       ),
        //       label: 'Categorias',
        //     ),
        //   ],
        // ),
        body: BlocBuilder<ExpensesListController, ExpensesListState>(
            builder: (context, state) {
          if (state.status == ExpensesListStatus.loading) {
            return const Center(
                child: CircularProgressIndicator.adaptive(
              backgroundColor: Color(
                (0xff5EA3A3),
              ),
            ));
          } else if (state.status == ExpensesListStatus.loaded) {
            if (state.expenses.isEmpty) {
              return const Center(
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
              );
            }
            if (state.expenses.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 8.0, bottom: 36.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Meus Gastos",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        initialPage: 0,
                        enlargeCenterPage: true,
                        pauseAutoPlayOnTouch: true,
                        aspectRatio: 16 / 9,
                      ),
                      items: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_downward,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const Text(
                                "R\$ 3000,00",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Entradas",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const Text(
                                "R\$ 1800,00",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Saídas",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Lançamentos",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.expenses.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(state.expenses[index].id.toString()),
                          onDismissed: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              await controller
                                  .deleteEntry(state.expenses[index]);
                              scaffold.showSnackBar(
                                const SnackBar(
                                  content: Text("Gasto excluído com sucesso"),
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
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 36.0,
                                                  left: 8.0,
                                                  bottom: 18.0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Editar lançamento",
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
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 16.0),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.05),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: TextFormField(
                                                        controller:
                                                            categoryEditController,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "ex: Internet",
                                                          labelText: "Gasto",
                                                          labelStyle: TextStyle(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.7)),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                          border:
                                                              InputBorder.none,
                                                          fillColor:
                                                              Colors.grey,
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
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 16.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.05),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () {},
                                                                style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    elevation:
                                                                        3,
                                                                    disabledBackgroundColor:
                                                                        const Color(
                                                                            0xff5EA3A3)),
                                                                child:
                                                                    const Text(
                                                                  "Entrada",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black54),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () {},
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  elevation: 3,
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "Saída",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black54),
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
                                                      color: Colors.grey
                                                          .withOpacity(0.05),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                    child: TextFormField(
                                                        controller:
                                                            descriptionEditController,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "R\$ 0,00",
                                                                labelText:
                                                                    "Valor",
                                                                labelStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.7),
                                                                ),
                                                                hintStyle: const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                fillColor:
                                                                    Colors
                                                                        .orange,
                                                                prefixIcon:
                                                                    Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          16.0),
                                                                  width: 50,
                                                                  height: 50,
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              10.0),
                                                                          bottomLeft:
                                                                              Radius.circular(10.0))),
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .arrow_downward,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 30,
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
                                                  DropdownButton(
                                                    items: [],
                                                    value: "Categoria",
                                                    onChanged: (value) {},
                                                    dropdownColor: Colors.grey
                                                        .withOpacity(0.05),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10)),
                                                  ),
                                                  DropdownButton(
                                                    items: [],
                                                    onChanged: (value) {},
                                                    value: "Data",
                                                    dropdownColor: Colors.grey
                                                        .withOpacity(0.05),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10)),
                                                  ),
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
                                                          await controller
                                                              .updateEntry(
                                                                  Entry(
                                                            name:
                                                                categoryEditController
                                                                    .text,
                                                            value: double.parse(
                                                              descriptionEditController
                                                                  .text,
                                                            ),
                                                            entryType: state
                                                                .expenses[index]
                                                                .entryType,
                                                            category: state
                                                                .expenses[index]
                                                                .category,
                                                            categoryId: state
                                                                .expenses[index]
                                                                .categoryId,
                                                            dateCreated: state
                                                                .expenses[index]
                                                                .dateCreated,
                                                            id: state
                                                                .expenses[index]
                                                                .id,
                                                            dateUpdated: state
                                                                .expenses[index]
                                                                .dateUpdated,
                                                            entryDate: state
                                                                .expenses[index]
                                                                .entryDate,
                                                            isChanged: state
                                                                .expenses[index]
                                                                .isChanged,
                                                            isInativo: state
                                                                .expenses[index]
                                                                .isInativo,
                                                            uid: state
                                                                .expenses[index]
                                                                .uid,
                                                            uidFirebase: state
                                                                .expenses[index]
                                                                .uidFirebase,
                                                          ));
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
                                                        nav.pop();
                                                        categoryEditController
                                                            .clear();
                                                        descriptionEditController
                                                            .clear();
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
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                          },
                          secondaryBackground: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          background: Container(
                            color: Colors.green,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20.0),
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                          child: ListTile(
                            title: Text(state.expenses[index].name),
                            subtitle:
                                Text(state.expenses[index].value.toString()),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            if (state.status == ExpensesListStatus.error) {
              return const Center(
                  child: Text(
                "Erro ao carregar categorias.",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                ),
              ));
            }
          }
          return const SizedBox.shrink();
        }));
  }
}
