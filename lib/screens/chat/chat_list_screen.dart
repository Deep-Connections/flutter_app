import 'package:deep_connections/models/chats/chat/chat.dart';
import 'package:deep_connections/screens/chat/components/chat_list_tile.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../services/chat/chat_service.dart';

// https://medium.com/@ximya/tips-and-tricks-for-implementing-a-successful-chat-ui-in-flutter-190cd81bdc64

class ChatListScreen extends StatelessWidget {
  final ChatService chatService;

  const ChatListScreen({super.key, required this.chatService});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
      title: loc.chat_title,
      body: Column(
        children: [
          Expanded(
            child: GenericStreamBuilder(
              data: chatService.chatStream,
              builder: (context, chats) {
                return ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    Chat chat = chats[index];
                    return ChatListTile(chat: chat);
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              chatService.createChat("K4MwAM2MThWzWaS0Y5lNDiEg3kh2");
            },
            child: const Text('New chat'),
          )
        ],
      ),
    );
  }
}
