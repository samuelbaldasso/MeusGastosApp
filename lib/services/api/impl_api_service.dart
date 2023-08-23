import 'package:meus_gastos/models/category.dart';
import 'package:meus_gastos/models/entry.dart';
import 'package:meus_gastos/repositories/api/impl_api_repository.dart';
import 'package:meus_gastos/services/api/api_service.dart';

class ImplApiService implements ApiService {
  final ImplApiRepository apiRepository;

  ImplApiService(this.apiRepository);

  @override
  Future<List<Category>> getData(String uid) async =>
      await apiRepository.getData(uid);

  @override
  Future<void> deleteData(String uid, int id) async {
    return await apiRepository.deleteData(uid, id);
  }

  @override
  Future<void> saveData(String uid, Category categories) async {
    return await apiRepository.saveData(uid, categories);
  }
  
  @override
  Future<Category> getDataById(String uid, int id) async{
    return await apiRepository.getDataById(uid, id);
  }
  
  @override
  Future<void> updateData(String uid, Category category) async {
    return await apiRepository.updateData(uid, category);
  }

  @override
  Future<void> deleteEntry(String uid, int id) async {
    return await apiRepository.deleteEntry(uid, id);
  }

  @override
  Future<List<Entry>> getEntries(String uid) async{
    return await apiRepository.getEntries(uid);
  }

  @override
  Future<Entry> getEntryById(String uid, int id) async {
    return await apiRepository.getEntryById(uid, id);
  }

  @override
  Future<void> saveEntry(String uid, Entry entry) async => await apiRepository.saveEntry(uid, entry); 

  @override
  Future<void> updateEntry(String uid, Entry entry) async => await apiRepository.updateEntry(uid, entry); 
}
