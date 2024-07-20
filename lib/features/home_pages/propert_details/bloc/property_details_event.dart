part of 'property_details_bloc.dart';

@immutable
sealed class PropertyDetailsEvent {}

class GetPropertyDetailsEvent extends PropertyDetailsEvent {
  final int propertyId;

  GetPropertyDetailsEvent({required this.propertyId});
}
