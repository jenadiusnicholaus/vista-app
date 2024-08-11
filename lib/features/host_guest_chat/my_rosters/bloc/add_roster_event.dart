part of 'add_roster_bloc.dart';

@immutable
sealed class AddRosterEvent {}

final class AddRoster extends AddRosterEvent {
  final String localuser;
  final String localhost;
  final String user;
  final String host;
  final String nick;
  final List<String>? groups;
  final String? subs;

  AddRoster({
    required this.localuser,
    required this.localhost,
    required this.user,
    required this.host,
    required this.nick,
    this.groups,
    this.subs,
  });
}
