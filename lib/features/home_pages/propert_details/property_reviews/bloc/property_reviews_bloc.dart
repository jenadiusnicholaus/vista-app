import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../repository.dart';

part 'property_reviews_event.dart';
part 'property_reviews_state.dart';

class PropertyReviewsBloc
    extends Bloc<PropertyReviewsEvent, PropertyReviewsState> {
  final PropertyReviewsRepository propertyReviewsRepository;
  PropertyReviewsBloc({required this.propertyReviewsRepository})
      : super(PropertyReviewsInitial()) {
    on<PropertyReviewsEvent>((event, emit) {});

    on<AddPropertyReviewEvent>((event, emit) async {
      emit(AddPropertyReviewsLoading());
      try {
        await propertyReviewsRepository.addPropertyReviews(
            propertyId: event.propertyId,
            rating: event.rating,
            comment: event.comment);
        emit(AddPropertyReviewsSuccess(
            message: "Property reviews added successfully"));
      } catch (e) {
        print(e);
        var errorMessage = "Failed to add property reviews";
        // var error = ExceptionHandler.handleError(e);
        emit(AddPropertyReviewsFailure(
          errorMessage: errorMessage,
        ));
      }
    });
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
