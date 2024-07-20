import 'dart:developer';

import 'package:get/get.dart';
import 'package:vista/features/home_pages/category/models.dart';
import 'package:vista/shared/environment.dart';

import '../../../shared/api_call/api.dart';
import '../explore/repository.dart';

class CategoryController extends GetxController {
  var categories = <CResults>[].obs; // Observable list of categories
  final PropertyRepository properRepository = PropertyRepository(
      apiCall: DioApiCall(), environment: Environment.instance);

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      PropertyCategoriesModel propertyCategoryList = await properRepository
          .fetchPropertyCategories(pageNumber: 1, pageSize: 100);
      categories.value = propertyCategoryList.results!;
      log('Categories gx: ${categories.iterator.current}');
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
