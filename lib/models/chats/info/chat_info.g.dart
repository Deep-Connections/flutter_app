// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatInfoImpl _$$ChatInfoImplFromJson(Map<String, dynamic> json) =>
    _$ChatInfoImpl(
      unreadMessages: json['unreadMessages'] as int?,
    );

Map<String, dynamic> _$$ChatInfoImplToJson(_$ChatInfoImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unreadMessages', instance.unreadMessages);
  return val;
}
