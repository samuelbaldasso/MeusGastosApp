import 'package:meus_gastos/models/category.dart';

abstract class ApiRepository{
  Future<Category> getData(String uid);
}