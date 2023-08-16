import 'package:meus_gastos/models/category.dart';

abstract class ApiRepository {
  Future<List<Category>> getData(String uid);
  Future<void> saveData(String uid, Category category);
  Future<void> deleteData(String uid, int id);
  // Future<void> updateData(String uid, Category category);
}
