import 'dart:io';

import 'package:xmpp_plugin/xmpp_plugin.dart';

class ChatReopository {
  final _host = "192.168.1.181";
  final _port = "5222";
  final _resource = Platform.isAndroid ? "Android" : "iOS";

  Future<XmppConnection> connect({
    required String phoneNumber,
    required String password,
  }) async {
    final auth = {
      "user_jid": "$phoneNumber@$_host/$_resource",
      "password": password,
      "host": _host,
      "port": _port,
      "requireSSLConnection": false,
      "autoDeliveryReceipt": true,
      "useStreamManagement": true,
      "automaticReconnection": true,
    };

    XmppConnection flutterXmpp = XmppConnection(auth);
    await flutterXmpp.start(onError);
    await flutterXmpp.login();
    return flutterXmpp;
  }

  void onError(String error) {
    print("Error: $error");
  }
}
