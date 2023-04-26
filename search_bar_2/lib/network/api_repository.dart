import '../model/search_model.dart';

abstract class ApiRepository {
  Future<List<SearchModel>> getAllUsers();
}
