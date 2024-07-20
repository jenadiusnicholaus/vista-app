import 'package:vista/features/home_pages/explore/models.dart';
import 'package:vista/shared/api_call/api.dart';

import '../../../shared/environment.dart';
import '../category/models.dart';

class PropertyRepository {
  final DioApiCall apiCall;
  final Environment environment;
  PropertyRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<PropertListModel> fetchProperties(
      {required int pageNumber,
      required int pageSize,
      required String category}) async {
    var response = await apiCall.get(
        "${environment.getBaseUrl}${environment.PROPERTIES}?page_number=$pageNumber&page_size=$pageSize&category=$category");
    if (response.statusCode == 200) {
      PropertListModel propertListModel =
          PropertListModel.fromJson(response.data);
      return propertListModel;
    } else {
      throw Exception(response.data);
    }
  }

// GET CATEGORIES
  Future<PropertyCategoriesModel> fetchPropertyCategories(
      {required int pageNumber, required int pageSize}) async {
    var response = await apiCall.get(
        "${environment.getBaseUrl}${environment.PROPERTY_CATEGORIES}?page_number=$pageNumber&page_size=$pageSize");
    if (response.statusCode == 200) {
      PropertyCategoriesModel propertListModel =
          PropertyCategoriesModel.fromJson(response.data);

      return propertListModel;
    } else {
      throw Exception(response.data);
    }
  }
}
