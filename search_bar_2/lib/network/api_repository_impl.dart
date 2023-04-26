import 'package:search_bar_2/model/search_model.dart';
import 'package:search_bar_2/network/api_client.dart';
import 'package:search_bar_2/network/api_repository.dart';

class ApiRepositoryImpl extends ApiRepository {
  
  static final ApiRepositoryImpl _singleton = ApiRepositoryImpl._internal();
   
  factory ApiRepositoryImpl() {
    return _singleton;
  }

  ApiRepositoryImpl._internal();

  final dio = ApiClient().client;

  @override
  Future<List<SearchModel>> getAllUsers() async {
    final response = await dio.get(
      "https://jsonplaceholder.typicode.com/users",
    );

    if (response.statusCode == 200) {
      return (response.data as List<dynamic>).map((json) {
        return SearchModel.fromJson(json);
      }).toList();
    } else {
      throw Exception(response.statusCode.toString());
    }
  }
}
