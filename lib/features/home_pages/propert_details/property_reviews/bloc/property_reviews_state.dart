part of 'property_reviews_bloc.dart';

@immutable
sealed class PropertyReviewsState {}

final class PropertyReviewsInitial extends PropertyReviewsState {}

final class AddPropertyReviewsLoading extends PropertyReviewsState {}

final class AddPropertyReviewsSuccess extends PropertyReviewsState {
  final String message;

  AddPropertyReviewsSuccess({required this.message});
}

final class AddPropertyReviewsFailure extends PropertyReviewsState {
  final String errorMessage;

  AddPropertyReviewsFailure({required this.errorMessage});
}
