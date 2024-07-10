import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class ChatPage extends StatefulWidget {
  final List<ChatMessage> initialMessages; // Accept initial messages

  ChatPage({Key? key, required this.initialMessages})
      : super(key: key); // Constructor

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessage> messages = []; // Messages list
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    messages =
        widget.initialMessages; // Initialize messages with initialMessages
  }

  void _sendMessage() {
    final text = _controller.text;
    // Create a new ChatMessage object and add it to the list
    final message = ChatMessage(
      id: DateTime.now().toString(),
      senderId: 'user1',
      receiverId: 'user2',
      message: text,
      timestamp: DateTime.now(),
      isSender: true,
    );
    setState(() {
      messages.add(message);
    });
    _controller.clear();

    // Simulate receiving a reply after a delay
    Future.delayed(Duration(seconds: 1), () {
      final replyMessage = ChatMessage(
        id: DateTime.now().toString(),
        senderId: 'user2',
        receiverId: 'user1',
        message: "Auto-reply to: $text",
        timestamp: DateTime.now(),
        isSender: false,
      );
      setState(() {
        messages.add(replyMessage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return ListTile(
                  title: Align(
                    alignment: msg.isSender
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: msg.isSender
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                      child: Text(msg.message),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
