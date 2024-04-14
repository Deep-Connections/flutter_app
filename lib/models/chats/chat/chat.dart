import 'package:deep_connections/models/chats/info/chat_info.dart';
import 'package:deep_connections/models/converters/timestamp_converter.dart';
import 'package:deep_connections/models/message/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const Chat._();

  const factory Chat({
    String? id,
    List<String>? participantIds,
    @TimestampConverter() DateTime? timestamp,
    Message? lastMessage,
    Map<String, ChatInfo>? chatInfos,

    /// not sent to the server
    String? currentUserId,
  }) = _Chat;

  String? get otherUserId {
    return participantIds?.firstWhere((id) => id != currentUserId);
  }

  ChatInfo? get info {
      return chatInfos?[currentUserId!];
  }

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
