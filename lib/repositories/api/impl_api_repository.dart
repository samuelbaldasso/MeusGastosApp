import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:meus_gastos/models/category.dart';
import 'package:meus_gastos/models/entry.dart';
import 'package:meus_gastos/repositories/api/api_repository.dart';

class ImplApiRepository implements ApiRepository {
  @override
  Future<List<Category>> getData(String uid) async {
    try {
      final result = await Dio().get(
          "http://meusgastos.codandocommoa.com.br/Api/Categorys/GetListaCategory?uIdFirebase=$uid");

      final categoriesList = (result.data as List<dynamic>).map((categoryData) {
        categoryData['EntryType'] = categoryData['EntryType'].toString();
        return Category.fromMap(categoryData);
      }).toList();
      return categoriesList
          .where((element) => element.isInativo == false)
          .toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> deleteData(String uid, int id) async {
    try {
      await Dio().post(
          "http://meusgastos.codandocommoa.com.br/Api/Categorys/InativarCategory?uIdFirebase=$uid&Id=$id");
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> saveData(String uid, Category category) async {
    try {
      await Dio().post(
          "http://meusgastos.codandocommoa.com.br/Api/Categorys/PostCategory",
          data: Category(
            name: category.name,
            description: category.description,
            entryType: category.entryType,
            isInativo: category.isInativo,
            dataAlteracao: category.dataAlteracao,
            dataCriacao: category.dataCriacao,
            id: category.id,
            uid: category.uid,
            uidFirebase: uid,
          ).toMap());
      // print(result.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> updateData(String uid, Category category) async {
    try {
      await saveData(
          uid,
          Category(
              name: category.name,
              description: category.description,
              entryType: category.entryType,
              isInativo: category.isInativo,
              dataAlteracao: category.dataAlteracao,
              dataCriacao: category.dataCriacao,
              id: category.id,
              uid: category.uid,
              uidFirebase: uid,
              isChanged: category.isChanged));
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<Category> getDataById(String uid, int id) async {
    try {
      final result = await Dio().get(
          "http://meusgastos.codandocommoa.com.br/Api/Categorys/GetCategoryById?uIdFirebase=$uid&Id=$id");

      final category = Category.fromMap(result.data);
      return category;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  //================================================================================================================

  @override
  Future<void> deleteEntry(String uid, int id) async {
    try {
      await Dio().post(
          "http://meusgastos.codandocommoa.com.br/Api/Entrys/InativarEntry?uIdFirebase=$uid&Id=$id");
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<List<Entry>> getEntries(String uid) async {
    try {
      final result = await Dio().get(
          "http://meusgastos.codandocommoa.com.br/Api/Entrys/GetListaEntry?uIdFirebase=$uid");
      final entriesList = (result.data as List<dynamic>).map((entryData) {
        entryData['EntryType'] = entryData['EntryType'].toString();
        return Entry.fromMap(entryData);
      }).toList();
      return entriesList
          .where((element) => element.isInativo == false)
          .toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<Entry> getEntryById(String uid, int id) async {
    try {
      final result = await Dio().get(
          "http://meusgastos.codandocommoa.com.br/Api/Entrys/GetEntryById?uIdFirebase=$uid&Id=$id");

      final entry = Entry.fromMap(result.data);
      return entry;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> saveEntry(String uid, Entry entry, int id) async {
    try {
      // Save the entry with the associated category
      final entryToSave = Entry(
        category: null,
        entryDate: entry.entryDate,
        id: entry.id,
        isInativo: entry.isInativo,
        dateCreated: entry.dateCreated,
        dateUpdated: entry.dateUpdated,
        uid: entry.uid,
        uidFirebase: uid,
        isChanged: entry.isChanged,
        categoryId: id, // Use the ID of the associated category
        entryType: entry.entryType,
        name: entry.name,
        value: entry.value,
      );
      log('Entry to Save: ${entryToSave.toMap().toString()}'); // Debug statement

      await Dio().post(
        "http://meusgastos.codandocommoa.com.br/Api/Entrys/PostEntry",
        data: entryToSave.toMap(),
      );
      // log(result.data.toString());
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> updateEntry(
      String uid, Entry entry, int id) async {
        // Assuming you have a copyWith method for Entry
    try {
      // Create a new Entry object with updated properties but keep the same Category
      final updatedEntry = Entry(
        category: entry.category, // Keep the same Category
        entryDate: entry.entryDate,
        id: entry.id,
        isInativo: entry.isInativo,
        dateCreated: entry.dateCreated,
        dateUpdated: entry.dateUpdated,
        uid: entry.uid,
        uidFirebase: uid,
        isChanged: entry.isChanged,
        categoryId: id,
        entryType: entry.entryType,
        name: entry.name,
        value: entry.value,
      );

      await saveEntry(uid, updatedEntry, id);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

    Future<bool> isValidCategory(String uid, int categoryId) async {
    try {
      Category? category = await getDataById(uid, categoryId);
      if (category.isInativo == true) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
