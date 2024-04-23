import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/builders/future_or_builder.dart';
import 'package:deep_connections/screens/profile/components/vertical_image_view.dart';
import 'package:deep_connections/services/chat/chat_service.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';

class MatchProfileScreen extends StatelessWidget {
  final String chatId;
  final ChatService chatService;
  final ProfileService profileService;

  const MatchProfileScreen(
      {super.key,
      required this.chatId,
      required this.chatService,
      required this.profileService});

  @override
  Widget build(BuildContext context) {
    return FutureOrBuilder(
        futureOr: chatService.chatById(chatId),
        builder: (context, chat) {
          return FutureOrBuilder(
              futureOr: chat?.otherUserId
                  .let((userId) => profileService.profileByUserId(userId)),
              builder: (context, profile) {
                return BaseScreen(
                    title: profile?.firstName ?? "",
                    body: ListView(children: [
                      VerticalImageView(
                          imageUrls: profile?.pictures
                              ?.mapNotNull((e) => e.url)
                              .toList()),
                    ]));
              });
        });
  }
}
