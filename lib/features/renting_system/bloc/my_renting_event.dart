part of 'my_renting_bloc.dart';

@immutable
sealed class MyRentingEvent {}

class GetMyRenting extends MyRentingEvent {
  final dynamic propertyId;
  GetMyRenting(this.propertyId);
}

class AddMyRenting extends MyRentingEvent {
  final dynamic property;
  final dynamic rentingDuration;
  final dynamic totalPrice;
  final dynamic totalFamilyMember;
  final dynamic checkIn;
  final dynamic checkOut;
  final dynamic adults;
  final dynamic children;
  final RequestContext requestContext;

  AddMyRenting({
    required this.property,
    required this.checkIn,
    required this.checkOut,
    required this.adults,
    required this.children,
    required this.rentingDuration,
    required this.totalPrice,
    required this.totalFamilyMember,
    required this.requestContext,
  });
}

class UpdateMyRenting extends MyRentingEvent {
  final dynamic property;
  final dynamic rentingDuration;
  final dynamic totalPrice;
  final dynamic totalFamilyMember;
  final dynamic checkIn;
  final dynamic checkOut;
  final dynamic adults;
  final dynamic children;
  final RequestContext requestContext;
  final dynamic rentingId;

  UpdateMyRenting(
      {required this.property,
      required this.checkIn,
      required this.checkOut,
      required this.adults,
      required this.children,
      required this.rentingDuration,
      required this.totalPrice,
      required this.totalFamilyMember,
      required this.requestContext,
      required this.rentingId});
}
