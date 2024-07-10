import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../data/sample_data.dart';
import 'chat.dart'; // Add flutter_slidable package for swipe actions

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inbox'),
        ),
        body: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return Slidable(
              // Specify the action pane for the slidable
              startActionPane: ActionPane(
                motion: DrawerMotion(), // Use DrawerMotion or another motion
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
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(message.sender[0]),
                ),
                title: Text(message.subject),
                subtitle: Text(
                  message.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                isThreeLine: true,
                trailing: Text(
                  '${message.date.month}/${message.date.day}/${message.date.year}',
                ),
                onTap: () {
                  setState(() {
                    message.isRead = !message.isRead;
                  });

                  List<ChatMessage> initialMessages =
                      inboxMessages.map((inboxMessage) {
                    return ChatMessage(
                      id: inboxMessage
                          .id, // Assuming your inbox message model has an id
                      senderId:
                          'user1', // You might need to adjust this based on your app's logic
                      receiverId: 'user2', // Adjust based on your app's logic
                      message: inboxMessage
                          .body, // Assuming body contains the message text
                      timestamp: inboxMessage
                          .date, // Adjust if your model's date field is different

                      // change using index
                      isSender: index % 2 == 0,
                    );
                  }).toList();
                  print(initialMessages);
                  Get.to(ChatPage(
                    initialMessages: initialMessages,
                  ));
                },
              ),
            );
          },
        ));
  }
}
