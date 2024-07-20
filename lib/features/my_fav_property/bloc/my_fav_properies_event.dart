part of 'my_fav_properies_bloc.dart';

@immutable
sealed class MyFavProperiesEvent {}

class GetMyFavPropertiesEvent extends MyFavProperiesEvent {
  GetMyFavPropertiesEvent();
}

class RemoveMyFavPropertyEvent extends MyFavProperiesEvent {
  final int propertyId;
  RemoveMyFavPropertyEvent({required this.propertyId});
}

class AddMyFavPropertyEvent extends MyFavProperiesEvent {
  final int propertyId;
  AddMyFavPropertyEvent({required this.propertyId});
}
