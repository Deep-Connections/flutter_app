import 'package:deep_connections/models/chats/chat/chat.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/chat/components/chat_list_tile.dart';
import 'package:deep_connections/screens/chat/components/create_match_button.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/stream_builder.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/utils/error_handling.dart';
import 'package:flutter/cupertino.dart';
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
                return CustomScrollView(
                  slivers: [
                    if (chats.isNotEmpty)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            Chat chat = chats[index];
                            final chatId = chat.id!;
                            return ChatListTile(
                              chat: chat,
                              onTap: () async {
                                await context.push(MainRoutes.messages
                                    .parameterPath([chatId]));
                                chatService.markChatRead(chatId);
                              },
                              futureOrProfile: profileService
                                  .profileByUserId(chat.otherUserId),
                            );
                          },
                          childCount: chats.length,
                        ),
                      ),
                    StreamBuilder(
                        stream: profileService.profileStream,
                        builder: (context, snapshot) {
                          final profile = snapshot.data;
                          if (profile == null) {
                            return const SliverToBoxAdapter();
                          }
                          return SliverToBoxAdapter(
                            child: CreateMatchSection(
                              createMatch: () async {
                                final response =
                                    await chatService.createMatch();
                                MessageHandler.showResponseError(response, loc);
                              },
                              profile: profile,
                            ),
                          );
                        })
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
