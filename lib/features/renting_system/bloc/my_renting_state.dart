part of 'my_renting_bloc.dart';

@immutable
sealed class MyRentingState {}

final class MyRentingInitial extends MyRentingState {}

final class MyRentingLoading extends MyRentingState {}

final class MyRentingSuccess extends MyRentingState {
  final MyRentingModel myRentingModel;

  MyRentingSuccess({required this.myRentingModel});
}

final class MyRentingFailure extends MyRentingState {
  final String errorMessage;

  MyRentingFailure({required this.errorMessage});
}

//add my rentind infos state

final class AddMyRentingLoading extends MyRentingState {}

final class AddMyRentingSuccess extends MyRentingState {
  final String message;
  AddMyRentingSuccess({required this.message});
}

final class AddMyRentingFailure extends MyRentingState {
  final String errorMessage;

  AddMyRentingFailure({required this.errorMessage});
}

// udpate my renting

final class UpdateMyRentingLoading extends MyRentingState {}

final class UpdateMyRentingSuccess extends MyRentingState {
  final String message;
  UpdateMyRentingSuccess({required this.message});
}

final class UpdateMyRentingFailed extends MyRentingState {
  final String message;

  UpdateMyRentingFailed({required this.message});
}
