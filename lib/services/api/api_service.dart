import 'package:meus_gastos/models/category.dart';

abstract class ApiService {
  Future<List<Category>> getData(String uid);
}
