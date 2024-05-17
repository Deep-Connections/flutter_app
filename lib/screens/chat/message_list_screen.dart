import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/chat/components/message_scroll_view.dart';
import 'package:deep_connections/screens/chat/components/message_text_field.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/builders/future_or_builder.dart';
import 'package:deep_connections/screens/components/image/avatar_image.dart';
import 'package:deep_connections/screens/components/pagination_controller.dart';
import 'package:deep_connections/screens/components/progress_indicator.dart';
import 'package:deep_connections/services/chat/chat_service.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                                        child: MessageScrollView(
                                          scrollController:
                                              paginationScrollController
                                                  .scrollController,
                                          messages: messages,
                                          currentUserId: currentUserId,
                                          matchProfile: matchProfile,
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
