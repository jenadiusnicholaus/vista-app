import 'package:vista/features/my_fav_property/models.dart';
import 'package:vista/shared/api_call/api.dart';
import 'package:vista/shared/environment.dart';

class MyFavoritePropertyRepository {
  final DioApiCall apiCall;
  final Environment environment;
  MyFavoritePropertyRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<GetMyFavPropertiesModel> getMyFavoriteProperties({
    int? pageNumber,
    int? pageSize,
  }) async {
    var response = await apiCall.get(
        "${environment.getBaseUrl}${environment.MY_FAVORITE_PROPERTY}?page_number=$pageNumber&page_size=$pageSize");
    if (response.statusCode == 200) {
      GetMyFavPropertiesModel myFavProperties =
          GetMyFavPropertiesModel.fromJson(response.data);

      return myFavProperties;
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> removeFavoriteProperty({int? propertyId}) async {
    var response = await apiCall.delete(
        "${environment.getBaseUrl}${environment.MY_FAVORITE_PROPERTY}/$propertyId");
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> addFavoriteProperty({int? propertyId}) async {
    var response = await apiCall.post(
        "${environment.getBaseUrl}${environment.MY_FAVORITE_PROPERTY}?property_id=$propertyId");
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.data);
    }
  }
}
