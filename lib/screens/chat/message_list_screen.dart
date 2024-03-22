import 'package:deep_connections/screens/chat/components/MessageTile.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:flutter/material.dart';

import '../../models/message.dart';

class MessageListScreen extends StatelessWidget {
  final String chatId;

  MessageListScreen({super.key, required this.chatId});

  final messageStream = Stream<List<Message>>.periodic(
    const Duration(seconds: 1),
    (count) => List.generate(count, (index) => index)
        .map((e) => Message(
            id: e.toString(),
            senderId: "1",
            text: "Hello $e",
            timestamp: DateTime.now()))
        .toList(),
  );

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: "Rosie",
        body: DcColumn(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: messageStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
                    return const Center(child: Text('No messages found'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      Message message = snapshot.data![index];
                      return MessageTile(message: message);
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
