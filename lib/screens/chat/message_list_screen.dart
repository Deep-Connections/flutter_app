import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/screens/chat/components/message_text_field.dart';
import 'package:deep_connections/screens/chat/components/message_tile.dart';
import 'package:deep_connections/screens/components/avatar_image.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/stream_builder.dart';
import 'package:deep_connections/services/chat/chat_service.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/message/message.dart';

class MessageListScreen extends StatelessWidget {
  final String chatId;
  final ChatService chatService;
  final ProfileService profileService;

  MessageListScreen({super.key,
    required this.chatId,
    required this.chatService,
    required this.profileService});

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        widgetTitle: EmptyStreamBuilder(
            data: chatService.chatByIdStream(chatId),
            builder: (context, chat) {
              return Row(children: [
                AvatarImage(imageUrl: chat.info?.imageUrl),
                const SizedBox(width: BASE_PADDING),
                Text(chat.info?.name ?? "")
              ]);
            }),
        body: Column(
          children: [
            Expanded(
              child: GenericStreamBuilder(
                data: chatService.messageStream(chatId),
                builder: (context, messages) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(BASE_PADDING),
                      controller: _scrollController,
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        Message message = messages[index];
                        return MessageTile(
                          message: message,
                          senderProfile:
                              profileService.profileByUserId(message.senderId),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: BASE_PADDING / 2, horizontal: BASE_PADDING),
              child: MessageTextField(
                  chatId: chatId,
                  chatService: chatService,
                  scrollController: _scrollController),
            )
          ],
        ));
  }
}
