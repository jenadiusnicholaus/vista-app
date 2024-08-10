part of 'my_rosters_bloc.dart';

@immutable
sealed class MyRostersEvent {}

final class GetMyRosters extends MyRostersEvent {
  final String username;
  final String host;
  GetMyRosters({required this.username, required this.host});
}
