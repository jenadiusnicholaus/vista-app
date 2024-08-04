part of 'xmppconnection_bloc.dart';

@immutable
sealed class XmppconnectionState {}

final class XmppconnectionInitial extends XmppconnectionState {}

final class XmppconnectionConnected extends XmppconnectionState {
  final XmppConnection flutterXmpp;

  XmppconnectionConnected(this.flutterXmpp);
}

final class XmppconnectionDisconnected extends XmppconnectionState {}

final class XmppconnectionError extends XmppconnectionState {
  final String message;

  XmppconnectionError(this.message);
}
