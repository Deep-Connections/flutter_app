import 'dart:async';

import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/chats/chat/chat.dart';
import 'package:deep_connections/models/message/message.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/components/builders/future_or_builder.dart';
import 'package:deep_connections/screens/components/dialogs/confirmation_dialog.dart';
import 'package:deep_connections/screens/components/image/avatar_image.dart';
import 'package:deep_connections/utils/extensions/date_time_extensions.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

const unreadSize = 20.0;

class ChatListTile extends StatelessWidget {
  final Chat chat;
  final FutureOr<Profile?> futureOrProfile;
  final void Function()? onTap;
  final void Function()? onDelete;

  const ChatListTile({
    super.key,
    required this.chat,
    required this.futureOrProfile,
    this.onTap,
    this.onDelete,
  });

  String _getMessageText(BuildContext context, Message? message) {
    final loc = AppLocalizations.of(context);
    if (message == null) return "";
    return switch (message) {
      MessageData() => message.text,
      MessageUnmatch() => loc.messages_unmatchedWithYou(message.senderFirstName)
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return FutureOrBuilder(
        futureOr: futureOrProfile,
        builder: (context, profile, _) {
          return Dismissible(
              key: ValueKey(chat.id),
              direction: profile?.firstName != null
                  ? DismissDirection.endToStart
                  : DismissDirection.none,
              confirmDismiss: (_) async {
                return await showDialog(
                  context: context,
                  builder: (context) => ConfirmationDialog(
                      context: context,
                      titleText:
                          loc.chat_unmatchDialogTitle(profile?.firstName ?? ""),
                      contentText: loc
                          .chat_unmatchDialogContent(profile?.firstName ?? ""),
                      confirmText: loc.chat_unmatchDialogButton,
                      onConfirm: onDelete),
                );
              },
              background: Container(
                color: Theme.of(context).colorScheme.error,
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: standardPadding),
                  child: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
              ),
              child: ListTile(
                onTap: onTap,
                leading: GestureDetector(
                  onTap: chat.id?.lambda((chatId) => context
                      .push(MainRoutes.matchProfile.parameterPath([chatId]))),
                  child: AvatarImage(
                    imageUrl: profile?.mainPictureUrl,
                    size: matchImageSize,
                  ),
                ),
                title: Text(profile?.firstName ?? ""),
                subtitle: Text(
                  _getMessageText(context, chat.lastMessage),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(chat.createdAt.toDependingOnDateString(loc, context,
                        todayAsTime: true)),
                    const SizedBox(height: standardPadding),
                    if (chat.isUnread)
                      Container(
                        width: unreadSize,
                        height: unreadSize,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            chat.unreadMessages?.toString() ?? "",
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ));
        });
  }
}
