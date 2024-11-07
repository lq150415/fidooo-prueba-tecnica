// lib/ui/widgets/message_list.dart
import 'package:chat/store/chat_store.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageList extends StatelessWidget {
  final ChatStore chatStore;
  const MessageList({super.key, required this.chatStore});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chatStore.messagesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No messages yet'));
        }

        final messages = snapshot.data!.docs;
        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(message['text']),
              subtitle: Text(message['sender'] ?? 'Anónimo'),
            );
          },
        );
      },
    );
  }
}
