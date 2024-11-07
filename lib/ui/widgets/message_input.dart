// lib/ui/widgets/message_input.dart
import 'package:chat/store/chat_store.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final ChatStore chatStore;
  final String sender;

  const MessageInput({super.key, required this.chatStore, required this.sender});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSend() {
    widget.chatStore.sendMessage(_messageController.text, widget.sender);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Escribe un mensaje',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _handleSend,
          ),
        ],
      ),
    );
  }
}
