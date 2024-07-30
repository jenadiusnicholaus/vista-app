import '../../../shared/api_call/api.dart';
import '../../../shared/environment.dart';
import 'models.dart';

class GuestRentalsRequestsRepository {
  final DioApiCall apiCall;
  final Environment environment;
  GuestRentalsRequestsRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<RentalsRequestModel> getGuestRentalsRequests(
      {required pageNumber, required pageSize}) async {
    final response = await apiCall.get(
      environment.getBaseUrl + environment.MY_RENTING_REQUEST,
    );
    if (response.statusCode == 200) {
      final bookingRequests = RentalsRequestModel.fromJson(response.data);
      return bookingRequests;
    } else {
      throw Exception('Failed to load booking requests');
    }
  }
}
