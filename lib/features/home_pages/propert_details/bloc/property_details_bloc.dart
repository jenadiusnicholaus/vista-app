import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../shared/error_handler.dart';
import '../models.dart';
import '../repository.dart';

part 'property_details_event.dart';
part 'property_details_state.dart';

class PropertyDetailsBloc
    extends Bloc<PropertyDetailsEvent, PropertyDetailsState> {
  final ProperDetailsRepository properDetailsRepository;
  PropertyDetailsBloc({required this.properDetailsRepository})
      : super(PropertyDetailsInitial()) {
    on<PropertyDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetPropertyDetailsEvent>((event, emit) async {
      emit(PropertyDetailsLoading());
      try {
        PropertyDetailsModel propertListModel = await properDetailsRepository
            .fetchPropertyDetails(propertyId: event.propertyId);
        emit(PropertyDetailsLoaded(propertyDetailsModel: propertListModel));
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);

        emit(PropertyDetailsError(error: errorMessage));
      }
    });
  }
}
