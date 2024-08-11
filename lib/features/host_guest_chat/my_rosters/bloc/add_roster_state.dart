part of 'add_roster_bloc.dart';

@immutable
sealed class AddRosterState {}

final class AddRosterInitial extends AddRosterState {}

final class AddRosterLoading extends AddRosterState {}

final class AddRosterSuccess extends AddRosterState {}

final class AddRosterFailure extends AddRosterState {
  final String error;

  AddRosterFailure(this.error);
}
