import 'package:vista/features/renting_system/models.dart';
import 'package:vista/shared/api_call/api.dart';

import '../../shared/environment.dart';

class RentingRepository {
  final DioApiCall apiCall;
  final Environment environment;
  RentingRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<MyRentingModel> getMyRenting(propertyId) async {
    var response = await apiCall.get(
        "${environment.getBaseUrl}${environment.MY_RENTING}?property_id=$propertyId");
    if (response.statusCode == 200) {
      MyRentingModel myRentingModel = MyRentingModel.fromJson(response.data);
      return myRentingModel;
    } else {
      throw Exception('Failed to load Renting infos');
    }
  }

  Future<dynamic> addMyRenting(
      {required dynamic propertyId,
      required dynamic rentingDurationId,
      required dynamic totalPrice,
      required dynamic totalFamilyMember,
      required String checkIn,
      required dynamic checkOut,
      required dynamic adults,
      required dynamic children}) async {
    var response = await apiCall
        .post(environment.getBaseUrl + environment.MY_RENTING, data: {
      "property": propertyId,
      "renting_duration": rentingDurationId,
      "total_price": totalPrice,
      "total_family_member": totalFamilyMember,
      "check_in": checkIn,
      "check_out": checkOut,
      "adult": adults,
      "children": children
    });
    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to added Renting infos');
    }
  }

  Future<dynamic> updateRenting(
      {required dynamic rentingId,
      required dynamic propertyId,
      required dynamic rentingDurationId,
      required dynamic totalPrice,
      required dynamic totalFamilyMember,
      required String checkIn,
      required dynamic checkOut,
      required dynamic adults,
      required dynamic children}) async {
    var response = await apiCall.patch(
        "${environment.getBaseUrl}${environment.MY_RENTING}?my_renting_id=$rentingId",
        {
          "property": propertyId,
          "renting_duration": rentingDurationId,
          "total_price": totalPrice,
          "total_family_member": totalFamilyMember,
          "check_in": checkIn,
          "check_out": checkOut,
          "adult": adults,
          "children": children
        });
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load dynamics');
    }
  }

  Future<dynamic> confirmRenting(
      {required dynamic rentingId,
      required dynamic paymentMethod,
      required dynamic accountNumber,
      required dynamic amount}) async {
    var data = {
      "payment_method": paymentMethod,
      "accountNumber": accountNumber,
      "amount": amount
    };
    var response = await apiCall.post(
        "${environment.getBaseUrl}${environment.CONFIRM_RENTING}?renting_id=$rentingId",
        data: data);

    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw response.data;
    }
  }

  Future<void> deleteRenting(String id) async {
    // return _rentingDataSource.deleteRenting(id);
  }
}
