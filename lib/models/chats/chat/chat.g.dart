// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatImpl _$$ChatImplFromJson(Map<String, dynamic> json) => _$ChatImpl(
      id: json['id'] as String?,
      participantIds: (json['participantIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      timestamp: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['timestamp'], const TimestampConverter().fromJson),
      lastMessage: json['lastMessage'] == null
          ? null
          : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
      chatInfos: (json['chatInfos'] as List<dynamic>?)
          ?.map((e) => ChatInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentUserId: json['currentUserId'] as String?,
    );

Map<String, dynamic> _$$ChatImplToJson(_$ChatImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('participantIds', instance.participantIds);
  writeNotNull(
      'timestamp',
      _$JsonConverterToJson<Timestamp, DateTime>(
          instance.timestamp, const TimestampConverter().toJson));
  writeNotNull('lastMessage', instance.lastMessage?.toJson());
  writeNotNull(
      'chatInfos', instance.chatInfos?.map((e) => e.toJson()).toList());
  writeNotNull('currentUserId', instance.currentUserId);
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
