import 'package:get/get.dart';
import 'package:search_bar_2/model/search_model.dart';

import '../network/api_repository_impl.dart';

class ApiViewModel extends GetxController with StateMixin<List<SearchModel>> {
  final RxList<SearchModel> _dataList = RxList();
  final RxList<SearchModel> filteredList = RxList();

  final apiRepositorySingleton = ApiRepositoryImpl();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    final getUserList = await apiRepositorySingleton.getAllUsers();

    _dataList.value = getUserList;
    filteredList.value = _dataList;

    try {
      if (filteredList.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(filteredList, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error('errorCode: $e'));
    }
  }

  void searchDataMethod(String searchData) {
    if (searchData.isEmpty) {
      filteredList.value = _dataList;
      change(filteredList, status: RxStatus.success());
    } else if (filteredList.isEmpty) {
      change([], status: RxStatus.empty());
    } else {
      filteredList.value = _dataList.where((apiData) {
        return apiData.name!.toLowerCase().contains(searchData.toLowerCase());
      }).toList();

      change(filteredList, status: RxStatus.success());
    }
  }
}
