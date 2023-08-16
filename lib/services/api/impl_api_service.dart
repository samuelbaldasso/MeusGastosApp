import 'package:meus_gastos/models/category.dart';
import 'package:meus_gastos/repositories/api/impl_api_repository.dart';
import 'package:meus_gastos/services/api/api_service.dart';

class ImplApiService implements ApiService {
  final ImplApiRepository apiRepository;

  ImplApiService(this.apiRepository);

  @override
  Future<List<Category>> getData(String uid) async =>
      await apiRepository.getData(uid);
}
