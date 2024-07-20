import '../../../../shared/api_call/api.dart';
import '../../../../shared/environment.dart';

class PropertyReviewsRepository {
  final DioApiCall apiCall;
  final Environment environment;
  PropertyReviewsRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<dynamic> addPropertyReviews(
      {required String propertyId,
      required double rating,
      required String comment}) async {
    var requestData = {"rating": rating, "comment": comment};
    var response = await apiCall.post(
        "${environment.getBaseUrl}${environment.PROPERTY_REVIEW}?property_id=$propertyId",
        data: requestData);

    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception(response.data);
    }
  }
}
