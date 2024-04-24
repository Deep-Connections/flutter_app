import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/builders/future_or_builder.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/profile/components/common_questions.dart';
import 'package:deep_connections/screens/profile/components/image_carousel.dart';
import 'package:deep_connections/services/chat/chat_service.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        builder: (context, chat, _) {
          return FutureOrBuilder(
              futureOr: chat?.otherUserId
                  .let((userId) => profileService.profileByUserId(userId)),
              builder: (context, profile, snapshot) {
                return BaseScreen(
                  title: profile?.firstName ?? "",
                  body: ListView(children: [
                    ImageCarousel(
                        pictures: profile?.pictures ?? [],
                        isLoading: snapshot.loading),
                    if (snapshot.completed &&
                        profile != null &&
                        profile.pictures.isNullOrEmpty)
                      NoImageWidget(profile: profile),
                    CommonAnswers(
                        profile1: profileService.profile, profile2: profile)
                  ]),
                );
              });
        });
  }
}

class NoImageWidget extends StatelessWidget {
  final Profile profile;

  const NoImageWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return DcColumn(children: [
      const Icon(Icons.no_photography),
      Text(
        loc.matchProfile_noUpload(profile.firstName ?? ""),
        style: theme.textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    ]);
  }
}
