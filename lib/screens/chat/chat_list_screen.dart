import 'package:deep_connections/models/chats/chat/chat.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/chat/components/chat_list_tile.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/stream_builder.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../services/chat/chat_service.dart';

class ChatListScreen extends StatelessWidget {
  final ChatService chatService;
  final ProfileService profileService;

  const ChatListScreen({
    super.key,
    required this.chatService,
    required this.profileService,
  });

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
                    final chatId = chat.id!;
                    return ChatListTile(
                        chat: chat,
                        unreadMessages: chat.info?.unreadMessages,
                        onTap: () async {
                          await context
                              .push("${MainRoutes.messages.fullPath}/$chatId");
                          chatService.markChatRead(chatId);
                        },
                        futureOrProfile:
                            profileService.profileByUserId(chat.otherUserId));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
