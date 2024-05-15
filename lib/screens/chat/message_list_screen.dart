import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/message/message.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/chat/components/bubble/message_bubble.dart';
import 'package:deep_connections/screens/chat/components/date_banner.dart';
import 'package:deep_connections/screens/chat/components/message_text_field.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/builders/future_or_builder.dart';
import 'package:deep_connections/screens/components/image/avatar_image.dart';
import 'package:deep_connections/screens/components/pagination_controller.dart';
import 'package:deep_connections/screens/components/progress_indicator.dart';
import 'package:deep_connections/services/chat/chat_service.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/extensions/date_time_extensions.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/language_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

// Layout for messages https://medium.com/@ximya/tips-and-tricks-for-implementing-a-successful-chat-ui-in-flutter-190cd81bdc64

class MessageListScreen extends StatefulWidget {
  final String chatId;
  final ChatService chatService;
  final ProfileService profileService;

  const MessageListScreen(
      {super.key,
      required this.chatId,
      required this.chatService,
      required this.profileService});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  final paginationScrollController = PaginationScrollController();

  @override
  void initState() {
    super.initState();

    paginationScrollController
        .init(() => widget.chatService.loadMoreMessages(widget.chatId));
  }

  @override
  void dispose() {
    paginationScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return FutureOrBuilder(
        futureOr: widget.chatService.chatById(widget.chatId),
        builder: (context, chat, _) {
          final currentUserId = chat?.currentUserId;
          return FutureOrBuilder(
              futureOr: chat?.otherUserId?.let((otherUserId) =>
                  widget.profileService.profileByUserId(otherUserId)),
              builder: (context, matchProfile, snapshot) {
                return BaseScreen(
                    widgetTitle: GestureDetector(
                      onTap: () => context.push(MainRoutes.matchProfile
                          .parameterPath([widget.chatId])),
                      behavior: HitTestBehavior.opaque,
                      child: Row(children: [
                        AvatarImage(
                            imageUrl: matchProfile?.profilePicture?.url),
                        const SizedBox(width: standardPadding),
                        Expanded(child: Text(matchProfile?.firstName ?? "")),
                      ]),
                    ),
                    body: Column(
                      children: [
                        Expanded(
                            child: currentUserId != null
                                ? StreamBuilder(
                                    stream: widget.chatService
                                        .messagesByChatIdStream(widget.chatId),
                                    builder: (context, snapshot) {
                                      final messages = snapshot.data ?? [];
                                      if (snapshot.hasData &&
                                          snapshot.data!.length < 20) {
                                        paginationScrollController
                                            .scrollListener();
                                      }
                                      if (!snapshot.hasData) {
                                        return const CenteredProgressIndicator();
                                      }
                                      return Align(
                                        alignment: Alignment.topCenter,
                                        child: CustomScrollView(
                                          controller: paginationScrollController
                                              .scrollController,
                                          shrinkWrap: true,
                                          reverse: true,
                                          slivers: [
                                            snapshot.data?.isEmpty == true
                                                ? SliverToBoxAdapter(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical:
                                                              standardPadding),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                              loc.chat_startConversation,
                                                              style: theme.textTheme
                                                                  .headlineSmall,
                                                              textAlign:
                                                              TextAlign.center),
                                                          const SizedBox(height: 150),
                                                          Center(
                                                            child: Text(
                                                                loc.chat_noMessages,
                                                                style: theme.textTheme.bodyLarge,
                                                                textAlign:
                                                                    TextAlign.center),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : SliverList(
                                                    delegate:
                                                        SliverChildBuilderDelegate(
                                                    (context, index) {
                                                      Message message =
                                                          messages[index];
                                                      final nextDate = index <
                                                              messages.length -
                                                                  1
                                                          ? messages[index + 1]
                                                              .createdAt
                                                          : null;
                                                      final isNewDay = nextDate
                                                              ?.isSameDay(message
                                                                  .createdAt) ==
                                                          false;
                                                      return Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                                standardPadding),
                                                        child: Column(
                                                          children: [
                                                            if (isNewDay ||
                                                                index ==
                                                                    messages.length -
                                                                        1)
                                                              DateBanner(
                                                                  date: message
                                                                      .createdAt),
                                                            MessageBubble(
                                                              message: message,
                                                              isRight:
                                                                  currentUserId ==
                                                                      message
                                                                          .senderId,
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    childCount: messages.length,
                                                  )),
                                            SliverToBoxAdapter(
                                              child: Container(
                                                  padding: const EdgeInsets.all(
                                                      standardPadding),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          loc.matchProfile_languages(
                                                              combinedLanguageText(
                                                                  context,
                                                                  matchProfile
                                                                      ?.languageWithCountryCodes)),
                                                          style: theme.textTheme
                                                              .bodyLarge,
                                                          textAlign:
                                                              TextAlign.center)
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : const CenteredProgressIndicator()),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: standardPadding / 2,
                              horizontal: standardPadding),
                          child: MessageTextField(
                              chatId: widget.chatId,
                              chatService: widget.chatService,
                              scrollController:
                                  paginationScrollController.scrollController),
                        )
                      ],
                    ));
              });
        });
  }
}
