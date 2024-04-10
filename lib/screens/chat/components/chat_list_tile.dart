import 'package:deep_connections/models/chats/chat/chat.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/components/avatar_image.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListTile extends StatelessWidget {
  final Chat chat;
  final bool isUnread;

  const ChatListTile({
    Key? key,
    required this.chat,
    this.isUnread = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: () {
        context.push("${MainRoutes.messages.fullPath}/${chat.id}");
      },
      leading: AvatarImage(imageUrl: chat.info?.imageUrl),
      title: Text(chat.info?.name ?? ""),
      subtitle: Text(
        chat.lastMessage?.text ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(chat.timestamp?.toHmString() ?? ""),
          if (isUnread)
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
