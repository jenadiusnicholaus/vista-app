part of 'xmppconnection_bloc.dart';

@immutable
sealed class XmppconnectionEvent {}

final class XmppconnectionConnect extends XmppconnectionEvent {
  final String phoneNumber;
  final String password;

  XmppconnectionConnect({
    required this.phoneNumber,
    required this.password,
  });
}
