import 'package:meus_gastos/models/category.dart';
import 'package:meus_gastos/models/entry.dart';

abstract class ApiRepository {
  Future<List<Category>> getData(String uid);
  Future<Category> getDataById(String uid, int id);
  Future<void> saveData(String uid, Category category);
  Future<void> deleteData(String uid, int id);
  Future<void> updateData(String uid, Category category);
  Future<List<Entry>> getEntries(String uid);
  Future<Entry> getEntryById(String uid, int id);
  Future<void> saveEntry(String uid, Entry entry, Category? selectedCategory);
  Future<void> deleteEntry(String uid, int id);
  Future<void> updateEntry(String uid, Entry entry, Category? selectedCategory);
}
