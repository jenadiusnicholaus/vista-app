part of 'property_reviews_bloc.dart';

@immutable
sealed class PropertyReviewsEvent {}

class AddPropertyReviewEvent extends PropertyReviewsEvent {
  final String propertyId;
  final double rating;
  final String comment;

  AddPropertyReviewEvent({
    required this.propertyId,
    required this.rating,
    required this.comment,
  });
}
