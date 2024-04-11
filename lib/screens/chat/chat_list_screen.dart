import 'package:deep_connections/models/chats/chat/chat.dart';
import 'package:deep_connections/screens/chat/components/chat_list_tile.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/stream_builder.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../services/chat/chat_service.dart';

// https://medium.com/@ximya/tips-and-tricks-for-implementing-a-successful-chat-ui-in-flutter-190cd81bdc64

class ChatListScreen extends StatelessWidget {
  final ChatService chatService;
  final ProfileService profileService;

  const ChatListScreen(
      {super.key, required this.chatService, required this.profileService});

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
                    final userId = chat.participantIds
                        ?.firstWhereOrNull((id) => id != chat.currentUserId);
                    return ChatListTile(
                        chat: chat,
                        profile: profileService.profileByUserId(userId));
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              chatService.createChat("FHzjtq4N3yZf1wo9xr1nYoM2EHA2");
            },
            child: const Text('New chat'),
          )
        ],
      ),
    );
  }
}
