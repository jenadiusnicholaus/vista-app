import '../../shared/api_call/api.dart';
import '../../shared/environment.dart';
import 'models.dart';

class SupportedRepository {
  final DioApiCall apiCall;
  final Environment environment;
  SupportedRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<SupportedRegionsModel> fetchRegions(
      {required int pageNumber, required int pageSize}) async {
    var response = await apiCall.get(
        "${environment.getBaseUrl}${environment.SUPPORTED_GEO_REGIONS}?page_number=$pageNumber&page_size=$pageSize");
    if (response.statusCode == 200) {
      SupportedRegionsModel supportedRegionsModel =
          SupportedRegionsModel.fromJson(response.data);
      return supportedRegionsModel;
    } else {
      throw Exception(response.data);
    }
  }
}
