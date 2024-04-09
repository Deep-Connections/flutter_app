import 'package:deep_connections/models/chats/info/chat_info.dart';
import 'package:deep_connections/models/message/message.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    String? id,
    List<String>? participantIds,
    DateTime? timestamp,
    Message? lastMessage,
    List<ChatInfo>? chatInfos,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
