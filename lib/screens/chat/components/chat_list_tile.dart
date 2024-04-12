import 'dart:async';

import 'package:deep_connections/models/chats/chat/chat.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/components/builders/future_or_builder.dart';
import 'package:deep_connections/screens/components/image/avatar_image.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

const unreadSize = 20.0;

class ChatListTile extends StatelessWidget {
  final Chat chat;
  final bool isUnread;
  final FutureOr<Profile?> futureOrprofile;

  const ChatListTile({
    Key? key,
    required this.chat,
    this.isUnread = true,
    required this.futureOrprofile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return FutureOrBuilder(
        futureOr: futureOrprofile,
        builder: (context, profile) {
          return ListTile(
            onTap: () {
              context.push("${MainRoutes.messages.fullPath}/${chat.id}");
            },
            leading: AvatarImage(imageUrl: profile?.profilePicture?.url),
            title: Text(profile?.firstName ?? ""),
            subtitle: Text(
              chat.lastMessage?.text ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(chat.timestamp
                        ?.toDependingOnDateString(loc, todayAsTime: true) ??
                    ""),
                if (isUnread)
                  Container(
                    width: unreadSize,
                    height: unreadSize,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
