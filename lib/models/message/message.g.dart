// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageDataImpl _$$MessageDataImplFromJson(Map<String, dynamic> json) =>
    _$MessageDataImpl(
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
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MessageDataImplToJson(_$MessageDataImpl instance) {
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
  val['runtimeType'] = instance.$type;
  return val;
}

_$MessageUnmatchImpl _$$MessageUnmatchImplFromJson(Map<String, dynamic> json) =>
    _$MessageUnmatchImpl(
      json['senderId'] as String,
      json['senderFirstName'] as String,
      json['chatId'] as String,
      const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      const TimestampConverter().fromJson(json['lastUpdatedAt'] as Timestamp),
      (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      id: json['id'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MessageUnmatchImplToJson(
    _$MessageUnmatchImpl instance) {
  final val = <String, dynamic>{
    'senderId': instance.senderId,
    'senderFirstName': instance.senderFirstName,
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
  val['runtimeType'] = instance.$type;
  return val;
}

_$MessageDeleteImpl _$$MessageDeleteImplFromJson(Map<String, dynamic> json) =>
    _$MessageDeleteImpl(
      json['senderId'] as String,
      json['senderFirstName'] as String,
      json['chatId'] as String,
      const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      const TimestampConverter().fromJson(json['lastUpdatedAt'] as Timestamp),
      (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      id: json['id'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MessageDeleteImplToJson(_$MessageDeleteImpl instance) {
  final val = <String, dynamic>{
    'senderId': instance.senderId,
    'senderFirstName': instance.senderFirstName,
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
  val['runtimeType'] = instance.$type;
  return val;
}
