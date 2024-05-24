import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/models/chats/info/chat_info.dart';
import 'package:deep_connections/models/converters/timestamp_converter.dart';
import 'package:deep_connections/models/message/message.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const Chat._();

  const factory Chat({
    required List<String> participantIds,
    required List<String> originalParticipantIds,
    @TimestampConverter() required DateTime createdAt,
    Map<String, ChatInfo>? chatInfos,
    @Freezed(fromJson: false, toJson: false) String? id,
    @Freezed(fromJson: false, toJson: false) Message? lastMessage,
    @Freezed(fromJson: false, toJson: false) int? unreadMessages,
    @Freezed(fromJson: false, toJson: false) String? currentUserId,
  }) = _Chat;

  String? get otherUserId {
    return (participantIds + originalParticipantIds).firstWhereOrNull((id) => id != currentUserId);
  }

  ChatInfo? get info {
    return chatInfos?[currentUserId!];
  }

  bool get hasSingleParticipant => participantIds.length == 1;

  bool get isUnread => unreadMessages != 0;

  DateTime? get lastRead => info?.lastRead;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
