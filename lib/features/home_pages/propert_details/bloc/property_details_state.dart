part of 'property_details_bloc.dart';

@immutable
sealed class PropertyDetailsState {}

final class PropertyDetailsInitial extends PropertyDetailsState {}

final class PropertyDetailsLoading extends PropertyDetailsState {}

final class PropertyDetailsLoaded extends PropertyDetailsState {
  final PropertyDetailsModel propertyDetailsModel;

  PropertyDetailsLoaded({required this.propertyDetailsModel});
}

final class PropertyDetailsError extends PropertyDetailsState {
  final String error;

  PropertyDetailsError({required this.error});
}
