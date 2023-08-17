import 'package:meus_gastos/models/category.dart';

abstract class ApiService {
  Future<List<Category>> getData(String uid);
  Future<void> saveData(String uid, Category categories);
  Future<void> deleteData(String uid, int id);
  Future<Category> getDataById(String uid, int id);
  Future<void> updateData(String uid, int id);
}
