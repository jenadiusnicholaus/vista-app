import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vista/features/auth/user_profile/models.dart';
import 'package:vista/shared/utils/extentions.dart';
import 'package:xmpp_plugin/custom_element.dart';
import 'package:xmpp_plugin/error_response_event.dart';
import 'package:xmpp_plugin/models/chat_state_model.dart';
import 'package:xmpp_plugin/models/connection_event.dart';
import 'package:xmpp_plugin/models/message_model.dart';
import 'package:xmpp_plugin/models/present_mode.dart';
import 'package:xmpp_plugin/success_response_event.dart';
import 'package:xmpp_plugin/xmpp_plugin.dart';
import '../../data/sample_data.dart';
import '../../shared/native_log_helper.dart';
import '../../shared/utils/build_avatar.dart';
import 'chat.dart';
import 'my_rosters/bloc/my_rosters_bloc.dart';

class InboxPage extends StatefulWidget {
  final String u;
  final String v;
  const InboxPage({super.key, required this.u, required this.v});

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage>
    with WidgetsBindingObserver
    implements DataChangeEvents {
  final TextEditingController _hostController =
      TextEditingController(text: "192.168.1.181");
  final TextEditingController _createRostersController =
      TextEditingController();

  static late XmppConnection flutterXmpp;
  List<MessageChat> events = [];
  List<PresentModel> presentMo = [];
  String connectionStatus = "Disconnected";
  String connectionStatusMessage = "";
  List<dynamic> myMessages = [];
  bool loadingRoster = false;
  @override
  void initState() {
    log(widget.u);
    log(widget.v);

    checkStoragePermission();
    XmppConnection.addListener(this);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    log(connectionStatus);
    connect();

    if (connectionStatus == 'Authenticated') {
    } else if (connectionStatus == 'Disconnected') {
      connect();
      fetchRoester();
    }
  }

  Future<void> fetchRoester() async {
    BlocProvider.of<MyRostersBloc>(context).add(GetMyRosters(
        username: widget.u, host: _hostController.text.trimRight()));
  }

  Future<void> connect() async {
    log('Connecting to XMPP server');
    if (_hostController.text.isEmpty) {
      log('Host is empty');
      return;
    }

    final param = {
      "user_jid":
          "${widget.u.trimRight()}@${_hostController.text}/${Platform.isAndroid ? "Android" : "iOS"}",
      "password": widget.v.trimRight(),
      "host": _hostController.text,
      "port": '5222',
      // "serviceName": "ws://${_hostController.text}:5280/websocket/",
      "nativeLogFilePath": NativeLogHelper.logFilePath,
      "requireSSLConnection": false, // Set to true if SSL is required
      "autoDeliveryReceipt": true, // Enable if you need delivery receipts
      "useStreamManagement": true, // Enable if you need stream management
      "automaticReconnection": true,
    };

    try {
      flutterXmpp = XmppConnection(param);
      await flutterXmpp.start(_onError);
      await flutterXmpp.login();
      log('Connected to XMPP server successfully');
    } catch (e) {
      log('Error connecting to XMPP server: ${e.toString()}');
    }
  }

  List<Map<String, String>> transformRoster(String rosterList) {
    List<Map<String, String>> transformedRoster = [];

    // Remove the brackets and split by comma
    String cleanedRoster = rosterList.replaceAll(RegExp(r'[\[\]]'), '');
    List<String> entries = cleanedRoster.split(', ');

    for (String entry in entries) {
      List<String> parts = entry.split(': ');
      if (parts.length == 2) {
        String key = parts[0].replaceAll('+', '');
        String value = parts[1];
        transformedRoster.add({'username': key, 'jid': value});
      }
    }

    return transformedRoster;
  }

  @override
  void dispose() {
    XmppConnection.removeListener(this);
    WidgetsBinding.instance.removeObserver(this);
    log('didChangeAppLifecycleState() dispose');
    super.dispose();
  }

  void checkStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      final PermissionStatus _permissionStatus =
          await Permission.storage.request();
      if (_permissionStatus.isGranted) {
        String filePath = await NativeLogHelper().getDefaultLogFilePath();
        log('logFilePath: $filePath');
      } else {
        log('logFilePath: please allow permission');
      }
    } else {
      // String filePath = await NativeLogHelper().getDefaultLogFilePath();
      // log('logFilePath: $filePath');
    }
  }

  void _onError(error) {
    log('Error: $error');
  }

  createRoster() async {
    await flutterXmpp.createRoster(_createRostersController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<MyRostersBloc, MyRostersState>(
                builder: (context, state) {
              if (state is MyRostersLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is MyRostersError) {
                return Center(
                  child: Column(
                    children: [
                      const Icon(Icons.person_outline),
                      Text(state.errorMessage),
                    ],
                  ),
                );
              }

              if (state is MyRostersLoaded) {
                final myRosters = state.myRosters;

                if (myRosters.length == 0) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_outline),
                          Text(
                            "Not Contact",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: myRosters.length,
                    itemBuilder: (context, index) {
                      // final message = messages[index];

                      // final keyValuePairs =
                      //     transformRoster(myRosters.toString());

                      // log(keyValuePairs);

                      UserProfileModel myRoster = myRosters[index];

                      return Slidable(
                        // Specify the action pane for the slidable
                        startActionPane: ActionPane(
                          motion:
                              const DrawerMotion(), // Use DrawerMotion or another motion
                          children: [
                            // Define actions like deleting
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                setState(() => messages.removeAt(index));
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: buildAvatar(myRoster.userProfilePic),
                          title: Text(myRoster.firstName.toString()),
                          subtitle: Text(myRoster.email.toString()),
                          isThreeLine: true,
                          onTap: () async {
                            Get.to(() => ChatPage(
                                  flutterXmpp: flutterXmpp,
                                  from: widget.u,
                                  to: "${myRoster.phoneNumber}@${_hostController.text}",
                                  host: _hostController.text,
                                  toName: myRoster.firstName.toString(),
                                  toEmail: myRoster.email.toString(),
                                  toImage: myRoster.userProfilePic,
                                ));
                          },
                        ),
                      );
                    },
                  ),
                );
              }
              return Text('');
            })

            // else
            //   const Center(
            //     child: Column(
            //       children: [
            //         Icon(Icons.person_outline),
            //         Text("Not Contact"),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  @override
  void onXmppError(ErrorResponseEvent errorResponseEvent) {
    log('receiveEvent onXmppError: ${errorResponseEvent.toErrorResponseData().toString()}');
  }

  @override
  void onSuccessEvent(SuccessResponseEvent successResponseEvent) {
    log('receiveEvent successEventReceive: ${successResponseEvent.toSuccessResponseData().toString()}');
  }

  @override
  void onChatMessage(MessageChat messageChat) {
    if (messageChat.body == null && messageChat.body!.isNotEmpty) {
      events.add(messageChat);
      log('onChatMessage: ${messageChat.toEventData()}');
    }
  }

  @override
  void onGroupMessage(MessageChat messageChat) {
    events.add(messageChat);
    log('onGroupMessage: ${messageChat.toEventData()}');
  }

  @override
  void onNormalMessage(MessageChat messageChat) {
    events.add(messageChat);
    log('onNormalMessage: ${messageChat.toEventData()}');
  }

  @override
  void onPresenceChange(PresentModel presentModel) {
    presentMo.add(presentModel);
    // flutterXmpp.getMyRosters().then((value) => {
    //       setState(() {
    //         myRosters = value.map((e) {
    //           return e.toString();
    //         }).toList();
    //         // requestMamMessages();
    //       })
    //     });
    log('onPresenceChange ~~>>${presentModel.toJson()}');
  }

  @override
  void onChatStateChange(ChatState chatState) {
    log('onChatStateChange ~~>>$chatState');
  }

  @override
  void onConnectionEvents(ConnectionEvent connectionEvent) async {
    log('onConnectionEvents ~~>>${connectionEvent.toJson()}');

    // Update connection status and message
    setState(() {
      connectionStatus = connectionEvent.type!.toConnectionName();
      connectionStatusMessage = connectionEvent.error ?? '';
    });

    // Fetch roster if the connection is authenticated
    if (connectionStatus == "Authenticated") {
      try {
        await fetchRoester();
      } catch (e) {
        log('Error fetching roster: $e');
      }
    }
  }

  Future<void> disconnectXMPP() async => await flutterXmpp.logout();

  Future<String> joinMucGroups(List<String> allGroupsId) async {
    return await flutterXmpp.joinMucGroups(allGroupsId);
  }

  Future<bool> joinMucGroup(String groupId) async {
    return await flutterXmpp.joinMucGroup(groupId);
  }

  Future<void> addMembersInGroup(String groupName, List<String> members) async {
    await flutterXmpp.addMembersInGroup(groupName, members);
  }

  Future<void> addAdminsInGroup(
      String groupName, List<String> adminMembers) async {
    await flutterXmpp.addAdminsInGroup(groupName, adminMembers);
  }

  Future<void> getMembers(String groupName) async {
    await flutterXmpp.getMembers(groupName);
  }

  Future<void> getOwners(String groupName) async {
    await flutterXmpp.getOwners(groupName);
  }

  Future<void> getOnlineMemberCount(String groupName) async {
    await flutterXmpp.getOnlineMemberCount(groupName);
  }

  Future<void> removeMember(String groupName, List<String> membersJid) async {
    await flutterXmpp.removeMember(groupName, membersJid);
  }

  Future<void> removeAdmin(String groupName, List<String> membersJid) async {
    await flutterXmpp.removeAdmin(groupName, membersJid);
  }

  Future<void> addOwner(String groupName, List<String> membersJid) async {
    await flutterXmpp.addOwner(groupName, membersJid);
  }

  Future<void> removeOwner(String groupName, List<String> membersJid) async {
    await flutterXmpp.removeOwner(groupName, membersJid);
  }

  Future onReceiveMessage(dynamic event) async {
    // TODO : Handle the receive event
  }

  Future<void> getAdmins(String groupName) async {
    await flutterXmpp.getAdmins(groupName);
  }

  Future<void> changePresenceType(presenceType, presenceMode) async {
    await flutterXmpp.changePresenceType(presenceType, presenceMode);
  }

  String dropDownValue = 'Chat';
  var items = ['Chat', 'Group Chat'];

  ///
  String presenceType = 'available';
  var presenceTypeItems = [
    'available',
    'unavailable',
  ];

  ///
  String presenceMode = 'available';
  var presenceModeitems = [
    'chat',
    'available',
    'away',
    'xa',
    'dnd',
  ];

  List<Map<String, String?>> rosters(String rosters) {
    // Regular expression to match key-value pairs
    RegExp regExp = RegExp(r'\+(\d{12}): \+(\d{12}@[\d.]+)');

    // Find all matches
    Iterable<RegExpMatch> matches = regExp.allMatches(rosters);

    // Extract and log keys and values
    List<Map<String, String?>> keyValuePairs = matches.map((match) {
      return {
        'username': match.group(1),
        'jid': match.group(2),
      };
    }).toList();

    log(keyValuePairs.toString());

    return keyValuePairs;
  }

  List<CustomElement> customElements = [
    CustomElement(
        childBody: "test",
        childElement: "elem",
        elementName: "Name",
        elementNameSpace: "space")
  ];
}
