import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/models/converters/timestamp_converter.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@Freezed(fallbackUnion: "default")
sealed class Message with _$Message {
  const factory Message({
    required String senderId,
    required String text,
    required String chatId,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime lastUpdatedAt,
    required List<String> participantIds,
    @Freezed(fromJson: false, toJson: false) String? id,
  }) = MessageData;

  const factory Message.unmatch(
    String senderId,
    String senderFirstName,
    String chatId,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime lastUpdatedAt,
    List<String> participantIds, {
    @Freezed(fromJson: false, toJson: false) String? id,
  }) = MessageUnmatch;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
