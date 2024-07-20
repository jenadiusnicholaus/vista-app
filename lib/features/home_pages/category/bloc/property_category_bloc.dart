import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../shared/error_handler.dart';
import '../../explore/repository.dart';
import '../models.dart';

part 'property_category_event.dart';
part 'property_category_state.dart';

class PropertyCategoryBloc
    extends Bloc<PropertyCategoryEvent, PropertyCategoryState> {
  final PropertyRepository properDetailsRepository;
  PropertyCategoryBloc({required this.properDetailsRepository})
      : super(PropertyCategoryInitial()) {
    on<PropertyCategoryEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetPropertyCategoryEvent>((event, emit) async {
      emit(PropertyCategoryLoading());
      try {
        PropertyCategoriesModel propertyCategoryList =
            await properDetailsRepository.fetchPropertyCategories(
                pageNumber: 1, pageSize: 100);
        emit(
            PropertyCategoryLoaded(propertyCategoryList: propertyCategoryList));
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        emit(PropertyCategoryError(error: errorMessage));
      }
    });
  }
}
