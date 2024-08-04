import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/host_guest_chat/connection/repository.dart';
import 'package:xmpp_plugin/xmpp_plugin.dart';

part 'xmppconnection_event.dart';
part 'xmppconnection_state.dart';

class XmppconnectionBloc
    extends Bloc<XmppconnectionEvent, XmppconnectionState> {
  ChatReopository chatReopository = ChatReopository();
  XmppconnectionBloc() : super(XmppconnectionInitial()) {
    on<XmppconnectionEvent>((event, emit) {});

    on<XmppconnectionConnect>((event, emit) async {
      emit(XmppconnectionInitial());
      try {
        XmppConnection flutterXmpp = await chatReopository.connect(
          phoneNumber: event.phoneNumber,
          password: event.password,
        );
        emit(XmppconnectionConnected(flutterXmpp));
      } catch (e) {
        emit(XmppconnectionError(e.toString()));
      }
    });
  }
}
