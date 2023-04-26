import 'package:dio/dio.dart';

class ApiClient {
  late final Dio _dio;
  static final ApiClient _singleton = ApiClient._internal();

  factory ApiClient() {
    return _singleton;
  }

  ApiClient._internal() {
    _dio = Dio();
  }    

  Dio get client => _dio;
}
