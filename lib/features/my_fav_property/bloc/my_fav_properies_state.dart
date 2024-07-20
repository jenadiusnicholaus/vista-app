part of 'my_fav_properies_bloc.dart';

@immutable
sealed class MyFavProperiesState {}

final class MyFavProperiesInitial extends MyFavProperiesState {}

final class MyFavProperiesLoading extends MyFavProperiesState {}

final class MyFavProperiesLoaded extends MyFavProperiesState {
  final GetMyFavPropertiesModel myFavProperties;
  MyFavProperiesLoaded({required this.myFavProperties});
}

final class MyFavProperiesError extends MyFavProperiesState {
  final String error;
  MyFavProperiesError({required this.error});
}

//add  to my fav properties state

///adding loading state
///
class MyFavProperiesAddedLoading extends MyFavProperiesState {}

/// adding success state

final class MyFavProperiesAdded extends MyFavProperiesState {
  final GetMyFavPropertiesModel myFavProperties;
  MyFavProperiesAdded({required this.myFavProperties});
}

/// adding error state
final class MyFavProperiesAddError extends MyFavProperiesState {
  final String error;
  MyFavProperiesAddError({required this.error});
}



//remove  to my fav properties state



