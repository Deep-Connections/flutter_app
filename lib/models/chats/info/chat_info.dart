import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_info.freezed.dart';
part 'chat_info.g.dart';

@freezed
class ChatInfo with _$ChatInfo {
  const factory ChatInfo({
    int? unreadMessages,
  }) = _ChatInfo;

  factory ChatInfo.fromJson(Map<String, dynamic> json) =>
      _$ChatInfoFromJson(json);
}
