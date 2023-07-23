import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:udemy_lessons/widgets/chat_messages_widget.dart';
import 'package:udemy_lessons/widgets/new_message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void pushNotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    fcm.subscribeToTopic('chat');

    // Use below code to get fcm token for notification
    // only works with android devices
    // final fcmToken = await fcm.getToken();
    // print('TOKEN $fcmToken');
  }

  @override
  void initState() {
    super.initState();
    pushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: ChatMessagesWidget(),
          ),
          NewMessageWidget(),
        ],
      ),
    );
  }
}
