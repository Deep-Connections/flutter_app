import 'package:deep_connections/config/theme.dart';
import 'package:deep_connections/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageTextField extends StatefulWidget {
  final String chatId;
  final ChatService chatService;

  const MessageTextField(
      {super.key, required this.chatService, required this.chatId});

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final String text = _controller.text.trim();
    if (text.isNotEmpty) {
      // Process the message here (e.g., sending to a backend or adding to a chat list)
      widget.chatService.sendMessage(text, widget.chatId);
      _controller.clear(); // Clears the text field after the message is sent
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller,
            maxLines: null,
            decoration: InputDecoration(
              hintText: loc.chat_messageTextField,
              filled: true,
              fillColor: messageTextFieldColor,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, value, child) => IconButton(
              onPressed: value.text.trim().isNotEmpty ? _sendMessage : null,
              icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.send,
                    color: colors.onPrimary,
                  ))),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
