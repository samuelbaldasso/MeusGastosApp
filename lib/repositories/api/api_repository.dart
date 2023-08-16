import 'package:meus_gastos/models/category.dart';

abstract class ApiRepository {
  Future<List<Category>> getData(String uid);
}
