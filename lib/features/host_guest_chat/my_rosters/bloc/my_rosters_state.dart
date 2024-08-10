part of 'my_rosters_bloc.dart';

@immutable
sealed class MyRostersState {}

final class MyRostersInitial extends MyRostersState {}

final class MyRostersLoading extends MyRostersState {}

final class MyRostersLoaded extends MyRostersState {
  final List<UserProfileModel> myRosters;

  MyRostersLoaded(this.myRosters);
}

final class MyRostersError extends MyRostersState {
  final String errorMessage;

  MyRostersError(this.errorMessage);
}
