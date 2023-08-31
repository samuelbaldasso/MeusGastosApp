import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meus_gastos/core/base_state.dart';
import 'package:meus_gastos/models/entry.dart';
import 'package:meus_gastos/pages/categories_list/categories_list_controller.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CategoriesListController>().loadCategories();
      controller.loadExpenses();
    });
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
    final category = context.read<CategoriesListController>();
    String? selectedCategoryEdit;
    DateTime? selectedDate;
    String? selectedCategoryAdd;
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
                      for (var entry in state.expenses) {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: false,
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
                                          top: 36.0, left: 8.0, bottom: 18.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Adicionar lançamento",
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.7),
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
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: const EdgeInsets.only(
                                                bottom: 16.0),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.05),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          entry.entryType = "0";
                                                          controller
                                                              .updateEntry(
                                                                  entry);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                elevation: 3,
                                                                foregroundColor:
                                                                    const Color(
                                                                        0xff5EA3A3)),
                                                        child: const Text(
                                                          "Entrada",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          entry.entryType = "1";
                                                          controller
                                                              .updateEntry(
                                                                  entry);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
                                                          elevation: 3,
                                                          foregroundColor:
                                                              const Color(
                                                                  0xff5EA3A3),
                                                        ),
                                                        child: const Text(
                                                          "Saída",
                                                          style: TextStyle(
                                                              fontSize: 16,
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
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.05),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: DropdownButton(
                                              items: state.categories
                                                  .map((category) {
                                                return DropdownMenuItem(
                                                  value: category.name,
                                                  child: Text(
                                                    category.name,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                );
                                              }).toList(),
                                              isExpanded: true,
                                              // underline:
                                              //     const SizedBox(),
                                              value: selectedCategoryAdd,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedCategoryAdd =
                                                      newValue;
                                                });
                                              },
                                              dropdownColor: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.05),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: DropdownButton(
                                              items: null,
                                              isExpanded: true,
                                              underline: const SizedBox(),
                                              onChanged: (value) async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2050),
                                                );

                                                if (pickedDate != null &&
                                                    pickedDate !=
                                                        selectedDate) {
                                                  selectedDate = pickedDate;
                                                }
                                              },
                                              value: selectedDate,
                                              dropdownColor:
                                                  Colors.grey.withOpacity(0.05),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                                  await controller
                                                      .addEntry(Entry(
                                                    name: addController.text,
                                                    value: double.parse(
                                                        addControllerValue
                                                            .text),
                                                  ));

                                                  addController.clear();
                                                  addControllerValue.clear();
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
                                                  category.loadCategories();
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xff5EA3A3),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                                      BorderRadius.circular(
                                                          8.0),
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
                          },
                        );
                      }
                    },
                    icon: const Icon(Icons.add, color: Color(0xff5EA3A3)))
              ]),
          body: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 8.0, bottom: 36.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16.0),
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
                    if (state.status == ExpensesListStatus.loading)
                      const Center(
                          child: CircularProgressIndicator.adaptive(
                        backgroundColor: Color(
                          (0xff5EA3A3),
                        ),
                      ))
                    else if (state.status == ExpensesListStatus.empty)
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
                    else if (state.status == ExpensesListStatus.loaded)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
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
                                      color: Colors.greenAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        Text(
                                          "R\$ ${controller.getTotalIn(state.expenses)}0",
                                          style: const TextStyle(
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
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        Text(
                                          "R\$ ${controller.getTotalOut(state.expenses)}0",
                                          style: const TextStyle(
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
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        Text(
                                          "R\$ ${controller.getTotalIn(state.expenses) - controller.getTotalOut(state.expenses)}0",
                                          style: const TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          "Total",
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
                                  return Builder(builder: (context) {
                                    return Dismissible(
                                      key: Key(
                                          state.expenses[index].id.toString()),
                                      onDismissed: (direction) async {
                                        if (direction ==
                                            DismissDirection.endToStart) {
                                          await controller.deleteEntry(
                                              state.expenses[index]);
                                          scaffold.showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Gasto excluído com sucesso"),
                                            ),
                                          );
                                        } else if (direction ==
                                            DismissDirection.startToEnd) {
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              isDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return FractionallySizedBox(
                                                  heightFactor: .9,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16.0),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 36.0,
                                                                  left: 8.0,
                                                                  bottom: 18.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "Editar lançamento",
                                                              style: TextStyle(
                                                                fontSize: 32,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Form(
                                                          key: key,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                margin: const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        16.0),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.05),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                child:
                                                                    TextFormField(
                                                                        controller:
                                                                            categoryEditController,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              "ex: Internet",
                                                                          labelText:
                                                                              "Gasto",
                                                                          labelStyle:
                                                                              TextStyle(color: Colors.grey.withOpacity(0.7)),
                                                                          hintStyle:
                                                                              const TextStyle(color: Colors.grey),
                                                                          border:
                                                                              InputBorder.none,
                                                                          fillColor:
                                                                              Colors.grey,
                                                                        ),
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "Gasto obrigatório";
                                                                          }
                                                                          return null;
                                                                        }),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                margin: const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        16.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.05),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          16.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              ElevatedButton(
                                                                            onPressed:
                                                                                () async {
                                                                              state.expenses[index].entryType = "0";
                                                                            },
                                                                            style: ElevatedButton.styleFrom(
                                                                                backgroundColor: Colors.white,
                                                                                elevation: 3,
                                                                                disabledBackgroundColor: const Color(0xff5EA3A3)),
                                                                            child:
                                                                                const Text(
                                                                              "Entrada",
                                                                              style: TextStyle(fontSize: 16, color: Colors.black54),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              state.expenses[index].entryType = "1";
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.white,
                                                                              elevation: 3,
                                                                            ),
                                                                            child:
                                                                                const Text(
                                                                              "Saída",
                                                                              style: TextStyle(fontSize: 16, color: Colors.black54),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.05),
                                                                  borderRadius: const BorderRadius
                                                                          .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                child: TextFormField(
                                                                    controller: descriptionEditController,
                                                                    decoration: InputDecoration(
                                                                        hintText: "R\$ 0,00",
                                                                        labelText: "Valor",
                                                                        labelStyle: TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.7),
                                                                        ),
                                                                        hintStyle: const TextStyle(color: Colors.grey),
                                                                        border: InputBorder.none,
                                                                        fillColor: Colors.orange,
                                                                        prefixIcon: Container(
                                                                          margin:
                                                                              const EdgeInsets.only(right: 16.0),
                                                                          width:
                                                                              50,
                                                                          height:
                                                                              50,
                                                                          decoration: const BoxDecoration(
                                                                              color: Colors.blue,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0))),
                                                                          child:
                                                                              const Icon(
                                                                            Icons.arrow_downward,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                        )),
                                                                    validator: (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        return "Gasto obrigatório";
                                                                      }
                                                                      return null;
                                                                    }),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.05,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.05),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                child:
                                                                    DropdownButton(
                                                                  items: controller
                                                                      .categories
                                                                      .map(
                                                                          (category) {
                                                                    return DropdownMenuItem(
                                                                      value: category
                                                                          .name,
                                                                      child:
                                                                          Text(
                                                                        category
                                                                            .name,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                  isExpanded:
                                                                      true,
                                                                  // underline:
                                                                  //     const SizedBox(),
                                                                  value:
                                                                      selectedCategoryEdit,
                                                                  onChanged:
                                                                      (newValue) {
                                                                    setState(
                                                                        () {
                                                                      selectedCategoryEdit =
                                                                          newValue;
                                                                    });
                                                                  },
                                                                  dropdownColor:
                                                                      Colors
                                                                          .white,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.05,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.05),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                child:
                                                                    DropdownButton(
                                                                  items: null,
                                                                  // isExpanded:
                                                                  //     true,
                                                                  // underline:
                                                                  //     const SizedBox(),
                                                                  onChanged:
                                                                      (value) async {
                                                                    DateTime?
                                                                        pickedDate =
                                                                        await showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          DateTime
                                                                              .now(),
                                                                      firstDate:
                                                                          DateTime(
                                                                              2000),
                                                                      lastDate:
                                                                          DateTime(
                                                                              2050),
                                                                    );

                                                                    if (pickedDate !=
                                                                            null &&
                                                                        pickedDate !=
                                                                            selectedDate) {
                                                                      selectedDate =
                                                                          pickedDate;
                                                                    }
                                                                  },
                                                                  value:
                                                                      selectedDate,
                                                                  dropdownColor: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.05),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 10.0,
                                                                  right: 10.0,
                                                                  top: 48.0,
                                                                  bottom: 36.0,
                                                                ),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    if (key.currentState
                                                                            ?.validate() ??
                                                                        false) {
                                                                      await controller.updateEntry(Entry(
                                                                          name: categoryEditController.text,
                                                                          value: double.parse(
                                                                            descriptionEditController.text,
                                                                          ),
                                                                          entryType: state.expenses[index].entryType,
                                                                          category: null,
                                                                          categoryId: state.expenses[index].category?.id,
                                                                          dateCreated: state.expenses[index].dateCreated,
                                                                          id: state.expenses[index].id,
                                                                          dateUpdated: state.expenses[index].dateUpdated,
                                                                          entryDate: state.expenses[index].entryDate,
                                                                          isChanged: state.expenses[index].isChanged,
                                                                          isInativo: state.expenses[index].isInativo,
                                                                          uid: state.expenses[index].uid,
                                                                          uidFirebase: state.expenses[index].uidFirebase));
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
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            18.0,
                                                                        bottom:
                                                                            18.0),
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "SALVAR",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right:
                                                                        10.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () async {
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
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            18.0,
                                                                        bottom:
                                                                            18.0),
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "CANCELAR",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
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
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: const Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                      background: Container(
                                        color: Colors.green,
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: const Icon(Icons.edit,
                                            color: Colors.white),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                state.expenses[index].entryType ==
                                                        "0"
                                                    ? Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    15.0)),
                                                        child: const Icon(
                                                            Icons
                                                                .arrow_downward,
                                                            color:
                                                                Colors.white))
                                                    : Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0)),
                                                        child: const Icon(
                                                            Icons.arrow_upward,
                                                            color: Colors.white)),
                                                const SizedBox(
                                                  width: 16.0,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(state
                                                        .expenses[index].name),
                                                    Text(state.categories[index]
                                                        .name),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(state.expenses[index]
                                                            .entryType ==
                                                        "0"
                                                    ? "+ ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(state.expenses[index].value)}"
                                                    : "- ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(state.expenses[index].value)}"),
                                                Text(DateFormat.yMd('pt-BR')
                                                    .format(state
                                                            .expenses[index]
                                                            .entryDate ??
                                                        DateTime.now())),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    else if (state.status == ExpensesListStatus.error)
                      const Center(
                          child: Text(
                        "Erro ao carregar categorias.",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                        ),
                      ))
                  ])));
    });
  }
}
