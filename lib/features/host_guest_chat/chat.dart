import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:vista/shared/utils/extentions.dart';
import 'package:xmpp_plugin/ennums/presence_type.dart';
import 'package:xmpp_plugin/error_response_event.dart';
import 'package:xmpp_plugin/models/chat_state_model.dart';
import 'package:xmpp_plugin/models/connection_event.dart';
import 'package:xmpp_plugin/models/message_model.dart';
import 'package:xmpp_plugin/models/present_mode.dart';
import 'package:xmpp_plugin/success_response_event.dart';
import 'package:xmpp_plugin/xmpp_plugin.dart';
import '../../data/sample_data.dart';

import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/src/skin_tones/skin_tone_config.dart';

import '../../shared/widgets/emoj_wedget.dart';

class ChatPage extends StatefulWidget {
  final XmppConnection flutterXmpp;
  final String from;
  final String to;
  final String host;

// Accept initial messages

  const ChatPage({
    super.key,
    required this.flutterXmpp,
    required this.from,
    required this.to,
    required this.host,
  }); // Constructor

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with WidgetsBindingObserver
    implements DataChangeEvents {
  List<ChatMessage> messages = []; // Messages list
  final TextEditingController _smsTextController = TextEditingController();
  // Create an instance of XmppPlugin
  List<MessageChat> events = [];
  List<PresentModel> presentMo = [];

  bool toIsOnLine = false;
  bool toIsTyping = false;
  // bool isMe = false;

  String connectionStatus = "Disconnected";
  String connectionStatusMessage = "";
  // List<dynamic> myRosters = [];
  List<dynamic> myMessages = [];
  final _scrollController = ScrollController();
  final _smsScrollController = ScrollController();
  late final TextStyle _textStyle;
  final bool isApple = [TargetPlatform.iOS, TargetPlatform.macOS]
      .contains(foundation.defaultTargetPlatform);
  bool _emojiShowing = false;
  final FocusNode _focusNode = FocusNode();
  ChatState? chatState;

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

  @override
  void initState() {
    super.initState();
    // send read status
    requestMamMessages();
    XmppConnection.addListener(this);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    log(connectionStatus);

    _smsTextController.addListener(() {
      if (_smsTextController.text.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      }
    });

    final fontSize = 24 * (isApple ? 1.2 : 1.0);
    _textStyle = DefaultEmojiTextStyle.copyWith(
      fontFamily: GoogleFonts.notoColorEmoji().fontFamily,
      fontSize: fontSize,
    );
  }

  bool getPresenceForUser(String userJid) {
    log('presentMo: $presentMo');
    var v = presentMo.where((element) => element.from == userJid);

    if (v.isNotEmpty && v.first.presenceType == PresenceType.available) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> requestMamMessages() async {
    String userJid = "${widget.to}@${widget.host}";
    DateTime since = DateTime.now().subtract(const Duration(days: 30));
    // before now
    DateTime before = DateTime.now();
    const int limit = 100;
    // Convert to timestamps
    int sinceTimestamp = since.millisecondsSinceEpoch;
    int beforeTimestamp = before.millisecondsSinceEpoch;
    String sinceTimestampString = sinceTimestamp.toString();
    String beforeTimestampString = beforeTimestamp.toString();

    try {
      await widget.flutterXmpp.requestMamMessages(userJid, sinceTimestampString,
          beforeTimestampString, limit.toString());

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    } on SocketException catch (e) {
      log('SocketException: $e');
    } catch (e) {
      log('Error: $e');
    }
  }

  void _sendMessage() async {
    final text = _smsTextController.text;
    if (text.isNotEmpty) {
      int id = DateTime.now().millisecondsSinceEpoch;
      await widget.flutterXmpp.sendMessageWithType(
          widget.to, text, "$id", DateTime.now().millisecondsSinceEpoch);
      _smsTextController.clear();
      // requestMamMessages();
      changePresenceType(presenceTypeItems[0], presenceModeitems[0]);
      _changeTypingStatus(widget.to, 'active');

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  @override
  void dispose() {
    XmppConnection.removeListener(this);
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _smsScrollController.dispose();
    _smsTextController.dispose();
    log('didChangeAppLifecycleState() dispose');
    super.dispose();
  }

  void _scrollToBottom() {
    _smsScrollController.animateTo(
      _smsScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void _changeTypingStatus(userJid, typingStatus) async {
    await widget.flutterXmpp.changeTypingStatus(userJid, typingStatus);
  }

  Future<void> changePresenceType(presenceType, presenceMode) async {
    await widget.flutterXmpp.changePresenceType(presenceType, presenceMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${widget.to.split('@')[0]}',
                    style: const TextStyle(fontSize: 16.0)),
              ],
            ),
            // typing status
            const SizedBox(height: 5.0),
            Row(
              children: [
                Text(
                  toIsOnLine
                      ? toIsTyping
                          ? 'Typing...'
                          : 'Online'
                      : '',
                  style: TextStyle(
                      fontSize: 12.0,
                      color: toIsOnLine ? Colors.green : Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: ChatScreen(
                events: events,
                from: widget.from,
                to: widget.to,
                host: widget.host,
                // isMe: isMe,
                smsScrollController: _smsScrollController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _emojiShowing = !_emojiShowing;
                        });
                      },
                      icon: _emojiShowing
                          ? const Icon(
                              Icons.emoji_emotions,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (text) {
                        if (text.isNotEmpty) {
                          _changeTypingStatus(widget.to, 'composing');
                        } else {
                          _changeTypingStatus(widget.to, "inactive");
                        }
                      },
                      focusNode: _focusNode,
                      controller: _smsTextController,
                      scrollController: _scrollController,
                      decoration:
                          const InputDecoration(hintText: 'Type a message'),
                    ),
                  ),
                  Material(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(100.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                      ),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: !_emojiShowing,
              child: EmojiPicker(
                textEditingController: _smsTextController,
                scrollController: _scrollController,
                config: Config(
                  height: 256,
                  checkPlatformCompatibility: true,
                  emojiTextStyle: _textStyle,
                  emojiViewConfig: const EmojiViewConfig(
                    backgroundColor: Colors.white,
                  ),
                  swapCategoryAndBottomBar: true,
                  skinToneConfig: const SkinToneConfig(),
                  categoryViewConfig: CategoryViewConfig(
                    backgroundColor: Colors.white,
                    dividerColor: Colors.white,
                    indicatorColor: accentColor,
                    iconColorSelected: Colors.black,
                    iconColor: secondaryColor,
                    customCategoryView: (
                      config,
                      state,
                      tabController,
                      pageController,
                    ) {
                      return WhatsAppCategoryView(
                        config,
                        state,
                        tabController,
                        pageController,
                      );
                    },
                    categoryIcons: const CategoryIcons(
                      recentIcon: Icons.access_time_outlined,
                      smileyIcon: Icons.emoji_emotions_outlined,
                      animalIcon: Icons.cruelty_free_outlined,
                      foodIcon: Icons.coffee_outlined,
                      activityIcon: Icons.sports_soccer_outlined,
                      travelIcon: Icons.directions_car_filled_outlined,
                      objectIcon: Icons.lightbulb_outline,
                      symbolIcon: Icons.emoji_symbols_outlined,
                      flagIcon: Icons.flag_outlined,
                    ),
                  ),
                  bottomActionBarConfig: const BottomActionBarConfig(
                    backgroundColor: Colors.white,
                    buttonColor: Colors.white,
                    buttonIconColor: secondaryColor,
                  ),
                  searchViewConfig: SearchViewConfig(
                    backgroundColor: Colors.white,
                    customSearchView: (
                      config,
                      state,
                      showEmojiView,
                    ) {
                      return WhatsAppSearchView(
                        config,
                        state,
                        showEmojiView,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime parseTimestamp(String timestamp) {
    return DateTime.parse(timestamp); // Parse the string to DateTime
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
    if (messageChat.body != null && messageChat.body!.isNotEmpty) {
      events.add(messageChat);
      _scrollToBottom();
      setState(() {});
    }

    log('onChatMessage: ${messageChat.toEventData()}');
  }

  @override
  void onGroupMessage(MessageChat messageChat) {
    events.add(messageChat);
    setState(() {});
    log('onGroupMessage: ${messageChat.toEventData()}');
  }

  @override
  void onNormalMessage(MessageChat messageChat) {
    var from = messageChat.from?.split('@')[0];
    var to = widget.to.split('@')[0];
    log('from-mmsksksk: $from');
    log('tom-m-msslsls: $to');
    log('chat state: ${messageChat.chatStateType.toString()}');

    if (from == to) {
      setState(() {
        toIsTyping = messageChat.chatStateType == 'composing';
      });
    } else {
      setState(() {
        toIsTyping = false;
      });
    }

    log('onNormalMessage: ${messageChat.toEventData()}');
  }

  @override
  void onPresenceChange(PresentModel presentModel) {
    // requestMamMessages();

    presentMo.add(presentModel);
    log(presentModel.from.toString());
    log(widget.to);

    var from = presentModel.from?.split('@')[0];
    var to = widget.to.split('@')[0];
    // if (presentModel.from == widget.to) {
    if (from == to) {
      setState(() {
        toIsOnLine = presentModel.presenceType == PresenceType.available;
      });
    }
    log('onPresenceChange ~~>>${presentModel.toJson()}');
  }

  @override
  void onChatStateChange(ChatState chatState) {
    log('onChatStateChange ~~>>$chatState');
  }

  @override
  void onConnectionEvents(ConnectionEvent connectionEvent) async {
    log('onConnectionEvents ~~>>${connectionEvent.toJson()}');
    connectionStatus = connectionEvent.type!.toConnectionName();
    connectionStatusMessage = connectionEvent.error ?? '';
    setState(() {});
  }
}

class MessageChatModel {
  final String body;

  MessageChatModel({required this.body});

  @override
  String toString() {
    return 'MessageChat{body: $body}';
  }
}

class ChatScreen extends StatelessWidget {
  final List<MessageChat> events;
  final String from;
  final String to;
  final String host;
  // final bool isMe;
  final ScrollController smsScrollController;

  const ChatScreen({
    super.key,
    required this.events,
    required this.from,
    required this.to,
    required this.host,
    required this.smsScrollController,
    // required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return GroupedListView<MessageChat, String>(
      reverse: false,
      shrinkWrap: true,
      controller: smsScrollController,
      elements: events,

      groupBy: (event) {
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch(int.parse(event.time!));
        return DateFormat('yyyy-MM-dd').format(dateTime); // Group by date
      },
      groupComparator: (value1, value2) => value2.compareTo(value2),
      itemComparator: (item1, item2) => item1.time!.compareTo(item2.time!),
      order: GroupedListOrder.ASC,
      // useStickyGroupSeparators: true,
      floatingHeader: true, // optional

      padding:
          const EdgeInsets.only(bottom: 60.0, right: 20, left: 20, top: 20),

      groupSeparatorBuilder: (String value) {
        DateTime dateTime = DateTime.parse(value);
        String formattedDate = DateFormat('EEEE, MMM d, yyyy')
            .format(dateTime); // Format date as 'Day, Month Date, Year'
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100.0),
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              formattedDate,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),
        );
      },
      itemBuilder: (context, event) {
        return _buildMessage(context, event);
      },
      // footer: const Center(
      //     child: Text("Powered by vista team",
      //         style: TextStyle(
      //           fontSize: 8.0,
      //           color: Colors.grey,
      //         ))),
    );
  }

  Widget _buildMessage(BuildContext context, MessageChat event) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(event.time!));
    String formattedTime =
        DateFormat('hh:mm a').format(dateTime); // Format time as 'hh:mm AM/PM'

    final isMe = event.from!.split('@')[0] == from;
    log('from: $from');
    log('event.from: ${event.from!.split('@')[0]}');
    log('to: $to');
    log('isMe: $isMe');
//
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    // Calculate the width dynamically based on the length of the event body
    double calculateWidth(String text) {
      int length = text.length;
      if (length <= 20) {
        return 120.0;
      } else if (length <= 40) {
        return 200.0;
      } else {
        return 300.0;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: calculateWidth(event.body.toString()),
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: isMe
                ? (isDarkTheme ? Colors.blue[700] : Colors.blue[100])
                : (isDarkTheme ? Colors.grey[800] : Colors.grey[200]),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isMe ? 15.0 : 0.0),
              topRight: Radius.circular(isMe ? 0.0 : 15.0),
              bottomLeft: const Radius.circular(15.0),
              bottomRight: const Radius.circular(15.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.body.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    Text(
                      formattedTime,
                      style: TextStyle(
                        color:
                            isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 8.0,
                      ),
                    ),
                    event.isReadSent == 1
                        ? const Icon(
                            Icons.done_all,
                            color: Colors.blue,
                            size: 16.0,
                          )
                        : const Icon(
                            Icons.done,
                            color: Colors.grey,
                            size: 16.0,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
