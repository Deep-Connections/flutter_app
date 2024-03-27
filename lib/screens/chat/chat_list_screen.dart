import 'package:deep_connections/models/chat/chat.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/utils/extensions/navigation.dart';
import 'package:deep_connections/utils/extensions/nullable.dart';
import 'package:flutter/material.dart';

import '../../services/chat/chat_service.dart';
import 'message_list_screen.dart';
// https://medium.com/@ximya/tips-and-tricks-for-implementing-a-successful-chat-ui-in-flutter-190cd81bdc64

class ChatListScreen extends StatelessWidget {
  final ChatService chatService;

  const ChatListScreen({super.key, required this.chatService});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Chat screen",
      body: DcColumn(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: chatService.getChatStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
                  return const Center(
                      child: Text('Please wait for your first match'));
                }
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    Chat chat = snapshot.data![index];
                    return ListTile(
                      title: Text(chat.id.toString()),
                      subtitle: const Text("chat.lastMessage"),
                      onTap: () {
                        chat.id.let((chatId) => context
                            .navigate(MessageListScreen(chatId: chatId)));
                      },
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              chatService.createChat("K4MwAM2MThWzWaS0Y5lNDiEg3kh2");
            },
            child: const Text('New chat'),
          )
        ],
      ),
    );
  }
}
