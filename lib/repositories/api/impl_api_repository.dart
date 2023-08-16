import 'package:dio/dio.dart';
import 'package:meus_gastos/models/category.dart';
import 'package:meus_gastos/repositories/api/api_repository.dart';

class ImplApiRepository implements ApiRepository {
  @override
  Future<List<Category>> getData(String uid) async {
    final result = await Dio().get(
        "http://meusgastos.codandocommoa.com.br/Api/Categorys/GetListaCategory?uIdFirebase=$uid");
    print(result);

    final categoriesList = (result.data as List<dynamic>).map((categoryData) {
      categoryData['EntryType'] = categoryData['EntryType'].toString();
      return Category.fromMap(categoryData);
    }).toList();

    return categoriesList;
  }
}
