import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udemy_lessons/widgets/message_bubble_widget.dart';

class ChatMessagesWidget extends StatelessWidget {
  const ChatMessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No Messages Found'),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        final messages = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 13,
            right: 13,
          ),
          // instead of top to bottom, widgets placed by bottom to top
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            final chatMessage = messages[index].data();
            final nextChatMessage =
                index + 1 < messages.length ? messages[index + 1].data() : null;

            final currentMessageUserID = chatMessage['userId'];
            final nextMessageUserID =
                nextChatMessage != null ? nextChatMessage['userId'] : null;

            final sameUser = currentMessageUserID == nextMessageUserID;

            if (sameUser) {
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: authenticatedUser!.uid == currentMessageUserID,
              );
            } else {
              return MessageBubble.first(
                userImage: chatMessage['userImage'],
                username: chatMessage['userName'],
                message: chatMessage['text'],
                isMe: authenticatedUser!.uid == currentMessageUserID,
              );
            }
          },
        );
      },
    );
  }
}
