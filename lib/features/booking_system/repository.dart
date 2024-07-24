import '../../shared/api_call/api.dart';
import '../../shared/environment.dart';
import 'models.dart';

class GuestBookingRepository {
  final DioApiCall apiCall;
  final Environment environment;
  GuestBookingRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<dynamic> create(booking) async {
    // return dataSource.create(booking);
  }

  Future<MyBookingModel> getMyBooking() async {
    var response = await apiCall
        .get(environment.getBaseUrl + environment.MY_BOOKING_VIEW_SET);

    if (response.statusCode == 200) {
      MyBookingModel myBookingModel = MyBookingModel.fromJson(response.data);
      return myBookingModel;
    } else {
      throw response.data;
    }
  }

  Future<dynamic> addBooking({
    required dynamic checkIn,
    required dynamic checkOut,
    required dynamic adults,
    required dynamic children,
    required propertyId,
    required totalPrice,
  }) async {
    var data = {
      "check_in": checkIn,
      "check_out": checkOut,
      "total_price": totalPrice,
      "adult": adults,
      "children": children,
    };
    var response = await apiCall.post(
        "${environment.getBaseUrl}${environment.MY_BOOKING_VIEW_SET}?property_id=$propertyId",
        data: data);

    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw response.data;
    }
  }

  Future<dynamic> updateBookingInfos({
    dynamic bookingId,
    required dynamic checkIn,
    required dynamic checkOut,
    required dynamic adults,
    required dynamic children,
    required totalPrice,
  }) async {
    var data = {
      "check_in": checkIn,
      "check_out": checkOut,
      "total_price": totalPrice,
      "adult": adults,
      "children": children,
    };

    var response = await apiCall.patch(
        "${environment.getBaseUrl}${environment.MY_BOOKING_VIEW_SET}?booking_info_id=$bookingId",
        data);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw response.data;
    }
  }
}
