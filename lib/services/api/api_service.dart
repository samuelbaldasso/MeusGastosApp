import 'package:meus_gastos/models/category.dart';

abstract class ApiService {
  Future<List<Category>> getData(String uid);
  Future<void> saveData(String uid, Category categories);
  Future<void> deleteData(String uid, int id);
}
