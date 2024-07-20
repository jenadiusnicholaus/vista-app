import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/my_fav_property/models.dart';

import '../../../shared/error_handler.dart';
import '../repository.dart';

part 'my_fav_properies_event.dart';
part 'my_fav_properies_state.dart';

class MyFavProperiesBloc
    extends Bloc<MyFavProperiesEvent, MyFavProperiesState> {
  final MyFavoritePropertyRepository myFavoritePropertyRepository;
  MyFavProperiesBloc({required this.myFavoritePropertyRepository})
      : super(MyFavProperiesInitial()) {
    on<MyFavProperiesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetMyFavPropertiesEvent>((event, emit) async {
      emit(MyFavProperiesLoading());
      try {
        final myFavProperties = await myFavoritePropertyRepository
            .getMyFavoriteProperties(pageNumber: 1, pageSize: 100);
        emit(MyFavProperiesLoaded(myFavProperties: myFavProperties));
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);

        emit(MyFavProperiesError(error: errorMessage));
      }
    });

    //add to my fav properties
    on<AddMyFavPropertyEvent>((event, emit) async {
      emit(MyFavProperiesAddedLoading());
      try {
        await myFavoritePropertyRepository.addFavoriteProperty(
            propertyId: event.propertyId);
        final myFavProperties = await myFavoritePropertyRepository
            .getMyFavoriteProperties(pageNumber: 1, pageSize: 100);
        emit(MyFavProperiesAdded(myFavProperties: myFavProperties));
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);

        emit(MyFavProperiesAddError(error: errorMessage));
      }
    });
  }
}
