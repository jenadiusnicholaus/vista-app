part of 'confirm_renting_bloc.dart';

@immutable
sealed class ConfirmRentingState {}

final class ConfirmRentingInitial extends ConfirmRentingState {}

final class ConfirmRentingLoading extends ConfirmRentingState {}

final class ConfirmRentingSuccess extends ConfirmRentingState {
  final String message;
  ConfirmRentingSuccess(this.message);
}

final class ConfirmRentingFailed extends ConfirmRentingState {
  final String message;
  ConfirmRentingFailed(this.message);
}
