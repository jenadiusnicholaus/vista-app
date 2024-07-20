import 'package:vista/shared/api_call/api.dart';

import '../../../shared/environment.dart';
import 'models.dart';

class ProperDetailsRepository {
  final DioApiCall apiCall;
  final Environment environment;
  ProperDetailsRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<PropertyDetailsModel> fetchPropertyDetails(
      {required int propertyId}) async {
    var response = await apiCall.get(
        "${environment.getBaseUrl}${environment.PROPERTY_DETAIL}?id=$propertyId");
    if (response.statusCode == 200) {
      PropertyDetailsModel propertyDetailsModel =
          PropertyDetailsModel.fromJson(response.data);
      return propertyDetailsModel;
    } else {
      throw Exception(response.data);
    }
  }
}
