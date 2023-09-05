import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meus_gastos/core/base_state.dart';
import 'package:meus_gastos/models/category.dart';
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
  String entryType = "0";
  DateTime? selectedDate;
  Category? selectedCategory;
  final categoryEditController = TextEditingController();
  final descriptionEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<CategoriesListController>(context).loadCategories();
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
                      isDismissible: false,
                      context: context,
                      builder: (context) {
                        return _buildBottomSheetContent(context, state);
                      });
                },
                icon: const Icon(Icons.add, color: Color(0xff5EA3A3)),
              )
            ],
          ),
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
                    else if (state.status == ExpensesListStatus.loaded)
                      if (state.expenses.isEmpty || state.categories.isEmpty)
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
                                SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.expenses.length,
                                    itemBuilder: (context, index) {
                                      var item = state.expenses[index];
                                      var cat = state.categories;
                                      return Builder(builder: (context) {
                                        return Dismissible(
                                          key: Key(item.id.toString()),
                                          onDismissed: (direction) async {
                                            if (direction ==
                                                DismissDirection.endToStart) {
                                              setState(() {
                                                state.expenses.removeAt(
                                                    index); // supondo que 'myList' é a sua lista de dados
                                              });
                                              await controller
                                                  .deleteEntry(item);
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    16.0),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 36.0,
                                                                      left: 8.0,
                                                                      bottom:
                                                                          18.0),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  "Editar lançamento",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        32,
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
                                                              key: keyEdit,
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            16.0),
                                                                    padding: const EdgeInsets
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
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child: TextFormField(
                                                                        controller: categoryEditController,
                                                                        decoration: InputDecoration(
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
                                                                        validator: (value) {
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
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          16.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: ElevatedButton(
                                                                                onPressed: () async {
                                                                                  item.entryType = "0";
                                                                                },
                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3, disabledBackgroundColor: const Color(0xff5EA3A3)),
                                                                                child: const Text(
                                                                                  "Entrada",
                                                                                  style: TextStyle(fontSize: 16, color: Colors.black54),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: ElevatedButton(
                                                                                onPressed: () {
                                                                                  item.entryType = "1";
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: Colors.white,
                                                                                  elevation: 3,
                                                                                ),
                                                                                child: const Text(
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
                                                                          topLeft: Radius.circular(
                                                                              10),
                                                                          topRight:
                                                                              Radius.circular(10)),
                                                                    ),
                                                                    child: Builder(
                                                                        builder:
                                                                            (context) {
                                                                      return TextFormField(
                                                                          controller:
                                                                              descriptionEditController,
                                                                          decoration: InputDecoration(
                                                                              hintText: "R\$ 0,00",
                                                                              labelText: "Valor",
                                                                              labelStyle: TextStyle(
                                                                                color: Colors.grey.withOpacity(0.7),
                                                                              ),
                                                                              hintStyle: const TextStyle(color: Colors.grey),
                                                                              border: InputBorder.none,
                                                                              fillColor: Colors.orange,
                                                                              prefixIcon: item.entryType == "0"
                                                                                  ? Container(
                                                                                      margin: const EdgeInsets.only(right: 16.0),
                                                                                      width: 50,
                                                                                      height: 50,
                                                                                      decoration: const BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0))),
                                                                                      child: const Icon(
                                                                                        Icons.arrow_downward,
                                                                                        color: Colors.white,
                                                                                        size: 30,
                                                                                      ),
                                                                                    )
                                                                                  : Container(
                                                                                      margin: const EdgeInsets.only(right: 16.0),
                                                                                      width: 50,
                                                                                      height: 50,
                                                                                      decoration: const BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0))),
                                                                                      child: const Icon(
                                                                                        Icons.arrow_upward,
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
                                                                          });
                                                                    }),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.05,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.grey.withOpacity(
                                                                              0.05),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0)),
                                                                      child: StatefulBuilder(builder:
                                                                          (context,
                                                                              setState) {
                                                                        return DropdownButton<
                                                                                Category>(
                                                                            items: state.categories.map(
                                                                                (category) {
                                                                              return DropdownMenuItem(
                                                                                value: category,
                                                                                child: Text(
                                                                                  category.name,
                                                                                  style: const TextStyle(color: Colors.black),
                                                                                ),
                                                                              );
                                                                            }).toList(),
                                                                            isExpanded:
                                                                                true,
                                                                            // underline:
                                                                            //     const SizedBox(),
                                                                            value:
                                                                                selectedCategory,
                                                                            onChanged:
                                                                                (newValue) {
                                                                              setState(() {
                                                                                selectedCategory = newValue;
                                                                              });
                                                                            },
                                                                            dropdownColor:
                                                                                Colors.white,
                                                                            borderRadius: const BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                            ));
                                                                      }),
                                                                    ),
                                                                  ),
                                                                  Builder(
                                                                      builder:
                                                                          (context,
                                                                              ) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              8.0),
                                                                      child: Container(
                                                                          width: MediaQuery.of(context).size.width,
                                                                          height: MediaQuery.of(context).size.height * 0.05,
                                                                          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.05), borderRadius: BorderRadius.circular(10.0)),
                                                                          child: ElevatedButton(
                                                                              onPressed: () async {
                                                                                DateTime? pickedDate = await showDatePicker(
                                                                                  context: context,
                                                                                  initialDate: DateTime.now(),
                                                                                  firstDate: DateTime(2000),
                                                                                  lastDate: DateTime(2050),
                                                                                );
                                                                                setState(() {
                                                                                  selectedDate = pickedDate;
                                                                                });
                                                                              },
                                                                              child: const Text(
                                                                                "Data do lançamento",
                                                                                style: TextStyle(color: Colors.white),
                                                                              ))),
                                                                    );
                                                                  }),
                                                                  Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          10.0,
                                                                      top: 48.0,
                                                                      bottom:
                                                                          36.0,
                                                                    ),
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (keyEdit.currentState?.validate() ??
                                                                            false) {
                                                                          final entryUpdated = Entry(
                                                                                  name: categoryEditController.text,
                                                                                  value: double.parse(
                                                                                    descriptionEditController.text,
                                                                                  ),
                                                                                  entryType: item.entryType,
                                                                                  category: null,
                                                                                  categoryId: selectedCategory?.id ?? 0,
                                                                                  dateCreated: item.dateCreated,
                                                                                  id: item.id,
                                                                                  dateUpdated: item.dateUpdated,
                                                                                  entryDate: selectedDate,
                                                                                  isChanged: item.isChanged,
                                                                                  isInativo: item.isInativo,
                                                                                  uid: item.uid,
                                                                                  uidFirebase: item.uidFirebase);

                                                                          await controller.updateEntry(
                                                                              entryUpdated,
                                                                              selectedCategory?.id ?? 0);
                                                                              
                                                                          nav.pop();
                                                                        }
                                                                      },
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            const Color(0xff5EA3A3),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        padding: const EdgeInsets.only(
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
                                                                        left:
                                                                            10.0,
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
                                                                        log(item.entryDate!.toString());
                                                                      },
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            const Color(0xff5EA3A3),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        padding: const EdgeInsets.only(
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
                                            padding: const EdgeInsets.only(
                                                right: 20.0),
                                            child: const Icon(Icons.delete,
                                                color: Colors.white),
                                          ),
                                          background: Container(
                                            color: Colors.green,
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: const Icon(Icons.edit,
                                                color: Colors.white),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    item.entryType == "0"
                                                        ? Container(
                                                            width: 30.0,
                                                            height: 30.0,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.blue,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        15.0)),
                                                            child: const Icon(
                                                                Icons
                                                                    .arrow_downward,
                                                                color: Colors
                                                                    .white))
                                                        : Container(
                                                            width: 30.0,
                                                            height: 30.0,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        15.0)),
                                                            child: const Icon(
                                                                Icons
                                                                    .arrow_upward,
                                                                color: Colors
                                                                    .white)),
                                                    const SizedBox(
                                                      width: 16.0,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(item.name),
                                                        Text(cat
                                                            .where((element) =>
                                                                element.id ==
                                                                state
                                                                    .expenses[
                                                                        index]
                                                                    .categoryId)
                                                            .toList()
                                                            .map((e) => e.name)
                                                            .toList()
                                                            .first),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(item.entryType == "0"
                                                        ? "+ ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(item.value)}"
                                                        : "- ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(item.value)}"),
                                                    Text(DateFormat.yMd('pt-BR')
                                                        .format(item.entryDate ?? DateTime.now())),

                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  ),
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

  Widget _buildBottomSheetContent(
      BuildContext context, ExpensesListState state) {
    final nav = Navigator.of(context);
    final scaffold = ScaffoldMessenger.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight * .9,
            minWidth: constraints.maxWidth,
          ),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 36.0, left: 8.0, bottom: 18.0),
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
                          margin: const EdgeInsets.only(bottom: 16.0),
                          padding: const EdgeInsets.only(left: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextFormField(
                              controller: addController,
                              decoration: InputDecoration(
                                hintText: "ex: Internet",
                                labelText: "Gasto",
                                labelStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.7)),
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                fillColor: Colors.grey,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Gasto obrigatório";
                                }
                                return null;
                              }),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              entryType = "0";
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              elevation: 3,
                                              foregroundColor:
                                                  const Color(0xff5EA3A3)),
                                          child: const Text(
                                            "Entrada",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ))),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          entryType = "1";
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        elevation: 3,
                                        foregroundColor:
                                            const Color(0xff5EA3A3),
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
                            color: Colors.grey.withOpacity(0.05),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          child: Builder(builder: (context) {
                            return TextFormField(
                                controller: addControllerValue,
                                decoration: InputDecoration(
                                    hintText: "R\$ 0,00",
                                    labelText: "Valor",
                                    labelStyle: TextStyle(
                                      color: Colors.grey.withOpacity(0.7),
                                    ),
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    fillColor: Colors.orange,
                                    prefixIcon: entryType == "0"
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                right: 16.0),
                                            width: 50,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    bottomLeft:
                                                        Radius.circular(10.0))),
                                            child: const Icon(
                                              Icons.arrow_downward,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.only(
                                                right: 16.0),
                                            width: 50,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                                color: Colors.redAccent,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    bottomLeft:
                                                        Radius.circular(10.0))),
                                            child: const Icon(
                                              Icons.arrow_upward,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Gasto obrigatório";
                                  }
                                  return null;
                                });
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(10.0)),
                            child:
                                StatefulBuilder(builder: (context, setState) {
                              return DropdownButton<Category>(
                                  items: state.categories.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(
                                        category.name,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  value: selectedCategory,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCategory = newValue;
                                    });
                                  },
                                  dropdownColor: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ));
                            }),
                          ),
                        ),
                        Builder(builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2050),
                                      );
                                      setState(() {
                                        selectedDate = pickedDate;
                                      });
                                    },
                                    child: const Text(
                                      "Data do lançamento",
                                      style: TextStyle(color: Colors.white),
                                    ))),
                          );
                        }),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            top: 48.0,
                            bottom: 36.0,
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (key.currentState?.validate() ?? false) {
                                final entry = Entry(
                                  name: addController.text,
                                  value: double.parse(addControllerValue.text),
                                  entryType: entryType,
                                  category: null,
                                  categoryId: selectedCategory?.id ?? 0,
                                  entryDate: selectedDate,
                                );
                                await controller.addEntry(
                                    entry, selectedCategory?.id ?? 0);
                                
                                addController.clear();
                                addControllerValue.clear();

                                scaffold.showSnackBar(const SnackBar(
                                  content: Text("Gasto adicionado com sucesso"),
                                  duration: Duration(seconds: 2),
                                ));
                                nav.pop();
                                controller.loadExpenses();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5EA3A3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
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
                          width: MediaQuery.of(context).size.width,
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller.loadExpenses();
                              nav.pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5EA3A3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
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
                    )),
              ])));
    });
  }
}
