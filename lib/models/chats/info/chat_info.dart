import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_info.freezed.dart';
part 'chat_info.g.dart';

@Deprecated("We no longer store infos per user in a chat")
@freezed
class ChatInfo with _$ChatInfo {
  const factory ChatInfo({
    String? userId,
    bool? unreadMessages,
  }) = _ChatInfo;

  factory ChatInfo.fromJson(Map<String, dynamic> json) =>
      _$ChatInfoFromJson(json);
}
