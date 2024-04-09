// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String?,
      senderId: json['senderId'] as String?,
      text: json['text'] as String?,
      chatId: json['chatId'] as String?,
      timestamp: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['timestamp'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('senderId', instance.senderId);
  writeNotNull('text', instance.text);
  writeNotNull('chatId', instance.chatId);
  writeNotNull(
      'timestamp',
      _$JsonConverterToJson<Timestamp, DateTime>(
          instance.timestamp, const TimestampConverter().toJson));
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
