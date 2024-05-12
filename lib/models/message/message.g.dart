// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      senderId: json['senderId'] as String,
      text: json['text'] as String,
      chatId: json['chatId'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      lastUpdatedAt: const TimestampConverter()
          .fromJson(json['lastUpdatedAt'] as Timestamp),
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) {
  final val = <String, dynamic>{
    'senderId': instance.senderId,
    'text': instance.text,
    'chatId': instance.chatId,
    'createdAt': const TimestampConverter().toJson(instance.createdAt),
    'lastUpdatedAt': const TimestampConverter().toJson(instance.lastUpdatedAt),
    'participantIds': instance.participantIds,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}
