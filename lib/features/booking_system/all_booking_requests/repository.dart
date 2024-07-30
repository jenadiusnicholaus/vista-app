
import '../../../shared/api_call/api.dart';
import '../../../shared/environment.dart';
import 'models.dart';

class GuestBookingRequestsRepository {
  final DioApiCall apiCall;
  final Environment environment;
  GuestBookingRequestsRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<BookingRequestModel> getGuestBookingRequests(
      {required pageNumber, required pageSize}) async {
    final response = await apiCall.get(
      environment.getBaseUrl + environment.MY_BOOKING_REQUEST,
    );
    if (response.statusCode == 200) {
      final bookingRequests = BookingRequestModel.fromJson(response.data);
      return bookingRequests;
    } else {
      throw Exception('Failed to load booking requests');
    }
  }
}
