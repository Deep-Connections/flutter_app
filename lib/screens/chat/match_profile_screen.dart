import 'package:age_calculator/age_calculator.dart';
import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/builders/future_or_builder.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/profile/components/common_questions.dart';
import 'package:deep_connections/screens/profile/components/image_carousel.dart';
import 'package:deep_connections/services/chat/chat_service.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/language_helper.dart';
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
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return FutureOrBuilder(
        futureOr: chatService.chatById(chatId),
        builder: (context, chat, _) {
          return FutureOrBuilder(
              futureOr: chat?.otherUserId
                  .let((userId) => profileService.profileByUserId(userId)),
              builder: (context, profile, snapshot) {
                final name = profile?.firstName ?? "";
                final age = profile?.dateOfBirth
                        ?.let((birthdate) => AgeCalculator.age(birthdate).years)
                        .toString() ??
                    "";
                final languages = combinedLanguageText(
                    context, profile?.languageWithCountryCodes);
                final gender = Gender.fromProfile(profile)?.localize(loc) ?? "";
                return BaseScreen(
                  title: name,
                  body: ListView(children: [
                    ProfileImageCarousel(profile: profile, snapshot: snapshot),
                    DcColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(
                            text: "$name, $age",
                            style: theme.textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: ", $gender",
                                style: theme.textTheme.bodyLarge,
                              )
                            ])),
                        Text(loc.matchProfile_languages(languages),
                            style: theme.textTheme.bodyLarge),
                      ],
                    ),
                    CommonAnswers(
                        profile1: profileService.profile, profile2: profile)
                  ]),
                );
              });
        });
  }
}
