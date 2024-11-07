import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/store/auth_store.dart';
import 'package:chat/store/chat_store.dart';
import '../widgets/message_list.dart';
import '../widgets/message_input.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    final chatStore = Provider.of<ChatStore>(context, listen: false);

    // Redirigir al login si el usuario no está autenticado
    if (authStore.user == null) {
      _redirectToLogin(context);
    }

    return Scaffold(
      appBar: _buildAppBar(context, authStore),
      body: _buildBody(chatStore, authStore),
    );
  }

  // Redirigir al login
  void _redirectToLogin(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  // Construir la AppBar
  AppBar _buildAppBar(BuildContext context, AuthStore authStore) {
    return AppBar(
      title: const Text('Chat'),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await authStore.signOut();
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ],
    );
  }

  // Construir el cuerpo con la lista de mensajes y el input
  Widget _buildBody(ChatStore chatStore, AuthStore authStore) {
    return Column(
      children: [
        Expanded(
          child: MessageList(chatStore: chatStore),
        ),
        MessageInput(
          chatStore: chatStore,
          sender: authStore.user?.email ?? 'Anónimo',
        ),
      ],
    );
  }
}
