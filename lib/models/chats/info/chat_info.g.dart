// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatInfoImpl _$$ChatInfoImplFromJson(Map<String, dynamic> json) =>
    _$ChatInfoImpl(
      lastRead: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastRead'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$ChatInfoImplToJson(_$ChatInfoImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'lastRead',
      _$JsonConverterToJson<Timestamp, DateTime>(
          instance.lastRead, const TimestampConverter().toJson));
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
