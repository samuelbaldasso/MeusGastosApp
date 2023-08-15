import 'package:meus_gastos/models/category.dart';

abstract class ApiService{
  Future<Category> getData(String uid);
  
}