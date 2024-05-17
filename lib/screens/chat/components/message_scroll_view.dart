import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/message/message.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/chat/components/bubble/message_bubble.dart';
import 'package:deep_connections/screens/chat/components/date_banner.dart';
import 'package:deep_connections/screens/chat/components/match_profile_languages.dart';
import 'package:deep_connections/screens/chat/components/unmatch_banner.dart';
import 'package:deep_connections/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageScrollView extends StatelessWidget {
  final ScrollController scrollController;
  final List<Message> messages;
  final String currentUserId;
  final Profile? matchProfile;

  const MessageScrollView(
      {super.key,
      required this.scrollController,
      required this.messages,
      required this.currentUserId,
      required this.matchProfile});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return CustomScrollView(
      controller: scrollController,
      shrinkWrap: true,
      reverse: true,
      slivers: messages.isEmpty
          ? [
              SliverFillRemaining(
                  child: Column(
                children: [
                  MatchProfileLanguages(matchProfile: matchProfile),
                  Text(loc.messages_startConversation,
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center),
                  Expanded(
                    child: Center(
                      child: Text(loc.messages_noMessages,
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center),
                    ),
                  )
                ],
              ))
            ]
          : [
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) {
                  Message message = messages[index];
                  final nextDate = index < messages.length - 1
                      ? messages[index + 1].createdAt
                      : null;
                  final isNewDay =
                      nextDate?.isSameDay(message.createdAt) == false;
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: standardPadding),
                    child: Column(
                      children: [
                        if (isNewDay || index == messages.length - 1)
                          DateBanner(date: message.createdAt),
                        switch (message) {
                          MessageData() => MessageBubble(
                              message: message,
                              isRight: currentUserId == message.senderId,
                            ),
                          MessageUnmatch() => UnmatchBanner(message),
                        },
                      ],
                    ),
                  );
                },
                childCount: messages.length,
              )),
              SliverToBoxAdapter(
                child: MatchProfileLanguages(matchProfile: matchProfile),
              ),
            ],
    );
  }
}
